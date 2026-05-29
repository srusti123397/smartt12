# Render Deployment Guide

This guide covers deploying the Smart Civic Reporting System to Render.

## Prerequisites

1. **GitHub Account** - Push your code to GitHub (Render deploys from Git)
2. **Render Account** - Sign up at [render.com](https://render.com)
3. **Environment Variables** - Have all required values ready

## Step 1: Push to GitHub

```bash
# Initialize git (if not already done)
git init
git add .
git commit -m "Initial commit for Render deployment"
git branch -M main

# Create a new GitHub repo and push
git remote add origin https://github.com/YOUR_USERNAME/smartg1.git
git push -u origin main
```

## Step 2: Create Render Services

### Option A: Using render.yaml (Recommended)

1. Go to [https://dashboard.render.com](https://dashboard.render.com)
2. Click **"New +"** → **"Blueprint"**
3. Paste your GitHub repo URL
4. Click **"Connect"**
5. Render will auto-detect and deploy both services using `render.yaml`

### Option B: Manual Creation

#### Backend Service
1. **New Web Service**
   - **Name:** `smart-backend`
   - **Environment:** Node
   - **Build Command:** `cd backend && npm install`
   - **Start Command:** `cd backend && npm start`
   - **Plan:** Free tier (or paid)

#### Frontend Service
1. **New Web Service**
   - **Name:** `smart-frontend`
   - **Environment:** Node
   - **Build Command:** `cd frontend && npm install && npm run build`
   - **Start Command:** `npx serve -s frontend/dist -l 3000`
   - **Plan:** Free tier (or paid)

## Step 3: Configure Environment Variables

### Backend Environment Variables

Navigate to **Backend Service** → **Environment** → Add these variables:

| Key | Value | Source |
|-----|-------|--------|
| `MONGO_URI` | `mongodb+srv://srustikan:Srusti%40123@ac-luw1zrt-shard-00-00.el3a1of.mongodb.net...` | From `.env` |
| `JWT_SECRET` | `node-super-secret-jwt-token-smart-reporting-2026` | From `.env` |
| `EMAIL_USER` | `rekhagb2004@gmail.com` | From `.env` |
| `EMAIL_PASS` | `vctlztlgcfdzobxr` | From `.env` |
| `MAPS_API_KEY` | `AIzaSyDq2mjRGuyQgzqrozBi7Ew7KgrC4FToI3I` | From `.env` |
| `NODE_ENV` | `production` | Set for prod |
| `UPLOAD_DIR` | `uploads` | Fixed value |

### Frontend Environment Variables

Navigate to **Frontend Service** → **Environment** → Add these variables:

| Key | Value |
|-----|-------|
| `VITE_GOOGLE_MAPS_API_KEY` | `AIzaSyDq2mjRGuyQgzqrozBi7Ew7KgrC4FToI3I` |
| `VITE_BACKEND_URL` | `https://smart-backend.onrender.com` *(Backend service URL)* |

⚠️ **Important:** Update `VITE_BACKEND_URL` after backend deploys. You'll get the URL like `https://smart-backend-xxxxx.onrender.com`

## Step 4: Verify Configuration

### Update Frontend Backend URL

After both services deploy, get the **Backend Service URL** from its Render dashboard.

Then update the Frontend service:
1. Go to Frontend Service → **Environment**
2. Update `VITE_BACKEND_URL` to the actual backend URL
3. Click **Save**
4. Trigger a manual deploy (or push new code)

### Test Endpoints

```bash
# Backend health check
curl https://your-backend-url.onrender.com/

# API config check
curl https://your-backend-url.onrender.com/api/config

# Frontend URL
https://your-frontend-url.onrender.com
```

## Step 5: First Deployment

### Watch Logs

Both services will show deployment logs. Check for:
- ✅ Build completed successfully
- ✅ Server running on port 5000 (backend)
- ✅ Server running on port 3000 (frontend)
- ❌ No MongoDB connection errors

### Common Issues & Fixes

#### Backend Won't Start

```
Error: Cannot find module 'jimp'
```
**Fix:** SSH into backend, run:
```bash
cd backend && npm install jimp
```

#### Frontend Can't Connect to Backend

**Cause:** `VITE_BACKEND_URL` not set correctly  
**Fix:** Check Frontend Environment Variables, ensure full URL like `https://smart-backend-xxxxx.onrender.com`

#### Uploads Not Persisting

**Note:** Render's free tier has ephemeral storage. Uploads are lost on redeploy.  
**Solution:** Store uploads to cloud (AWS S3, Google Cloud Storage) instead of local `/uploads`

## Step 6: Production Optimizations

### 1. Use MongoDB Atlas (Already Done ✓)
Your `MONGO_URI` is already pointing to MongoDB Atlas - good!

### 2. Configure CORS

Update `backend/server.js` if needed:
```javascript
app.use(cors({
  origin: 'https://your-frontend-url.onrender.com',
  credentials: true
}));
```

### 3. Enable SSL/HTTPS
- Render provides free SSL for all services ✓

### 4. Set Up Custom Domain (Optional)

In Render Dashboard → Service Settings → Custom Domain:
- Add your domain (e.g., `api.myapp.com`)
- Update DNS records as shown

## Step 7: Monitoring & Maintenance

### View Logs
- Backend: Service → Logs
- Frontend: Service → Logs

### Restart Services
- Settings → Restart Service

### Update Code
- Push to GitHub → Render auto-deploys (if auto-deploy enabled)

### Check Health
```bash
# Backend API health
curl https://your-backend-url/api/config

# Frontend loads
curl https://your-frontend-url
```

## Troubleshooting Checklist

- [ ] All environment variables set correctly
- [ ] MongoDB Atlas network access allows Render IPs (0.0.0.0/0)
- [ ] `VITE_BACKEND_URL` uses full backend service URL
- [ ] Backend started on port 5000
- [ ] Frontend running on port 3000
- [ ] No errors in deployment logs
- [ ] Check CORS configuration if frontend can't reach backend

## Support

For Render issues: [Render Docs](https://render.com/docs)  
For Node.js issues: Check `backend/` and `frontend/` README files

---

**Deployed!** 🚀 Your app should now be live at `https://your-frontend-url.onrender.com`
