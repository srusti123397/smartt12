# Render Deployment Checklist

Before deploying to Render, complete these steps:

## 1. Git Repository Setup

- [ ] Create a GitHub repository: [https://github.com/new](https://github.com/new)
- [ ] Name it: `smartg1` (or your preference)
- [ ] Initialize local git:
  ```bash
  cd c:\Users\VinayGowda\OneDrive\Desktop\smartg1
  git init
  git add .
  git commit -m "Initial commit - ready for Render deployment"
  ```
- [ ] Add GitHub remote:
  ```bash
  git remote add origin https://github.com/YOUR_USERNAME/smartg1.git
  git branch -M main
  git push -u origin main
  ```

## 2. Environment Variables Preparation

Copy these from your `.env` file:

**Backend (save these temporarily):**
- `MONGO_URI` = `mongodb+srv://srustikan:Srusti%40123@ac-luw1zrt-shard-00-00.el3a1of.mongodb.net:27017,ac-luw1zrt-shard-00-01.el3a1of.mongodb.net:27017,ac-luw1zrt-shard-00-02.el3a1of.mongodb.net:27017/ecosmart_city?tls=true&authSource=admin&retryWrites=true&w=majority`
- `JWT_SECRET` = `node-super-secret-jwt-token-smart-reporting-2026`
- `EMAIL_USER` = `rekhagb2004@gmail.com`
- `EMAIL_PASS` = `vctlztlgcfdzobxr`
- `MAPS_API_KEY` = `AIzaSyDq2mjRGuyQgzqrozBi7Ew7KgrC4FToI3I`

**Frontend:**
- `VITE_GOOGLE_MAPS_API_KEY` = `AIzaSyDq2mjRGuyQgzqrozBi7Ew7KgrC4FToI3I`
- `VITE_BACKEND_URL` = *(will get after backend deploys)* e.g., `https://smart-backend-xxxxx.onrender.com`

## 3. Render Account & Blueprint

- [ ] Sign up at [render.com](https://render.com)
- [ ] Go to Dashboard: [https://dashboard.render.com](https://dashboard.render.com)
- [ ] Click **"New +"** → **"Blueprint"**
- [ ] Paste: `https://github.com/YOUR_USERNAME/smartg1.git`
- [ ] Click **"Connect GitHub"** and authorize
- [ ] Render will auto-detect `render.yaml` and show 2 services to deploy

## 4. Deploy Services

- [ ] Click **"Deploy"** (both backend and frontend will be added)
- [ ] Wait for builds to complete (~3-5 minutes each)
- [ ] Monitor logs for errors

### After Deployment:

- [ ] Backend Service → Copy the URL (looks like `https://smart-backend-xxxxx.onrender.com`)
- [ ] Frontend Service → Will be deployed at something like `https://smart-frontend-xxxxx.onrender.com`

## 5. Configure Frontend Backend URL

After backend is deployed:

1. Go to **Frontend Service** → **Environment**
2. Add/Update `VITE_BACKEND_URL`:
   ```
   https://smart-backend-xxxxx.onrender.com
   ```
   *(Replace `xxxxx` with your actual backend ID)*
3. Click **Save**
4. Trigger **Manual Deploy** from the Service page

## 6. Verify Deployment

Test these URLs:

```bash
# Backend health check
curl https://smart-backend-xxxxx.onrender.com/

# API config (should show maps key)
curl https://smart-backend-xxxxx.onrender.com/api/config

# Frontend should load
# Visit: https://smart-frontend-xxxxx.onrender.com
```

## 7. Test End-to-End

In the frontend app:
- [ ] Login works
- [ ] Upload image → AI detection runs → Shows valid/invalid
- [ ] Submit complaint → Success message appears
- [ ] Check MongoDB Atlas dashboard for new complaint records

## 8. Troubleshooting

### Backend Won't Start
- Check logs for jimp/image processing errors
- Ensure `MONGO_URI` is correctly set

### Frontend Can't Connect to Backend
- Verify `VITE_BACKEND_URL` is set and matches backend URL
- Check browser console for CORS errors

### Uploads Lost After Redeploy
- Render has ephemeral storage - use cloud storage (S3) for production

### MongoDB Connection Failed
- Ensure MongoDB Atlas network allows Render IPs (set to 0.0.0.0/0)
- Check username/password in `MONGO_URI`

## 9. Continuous Deployment

After initial setup:
- [ ] Push code changes to GitHub
- [ ] Render auto-deploys on push (if enabled)
- [ ] Check deployment status in Render dashboard

## 10. Maintenance

- [ ] Monitor service logs weekly
- [ ] Update environment variables if needed (Settings → Environment)
- [ ] Test critical flows monthly
- [ ] Keep GitHub repo updated with latest code

---

## Quick Links

- Render Dashboard: https://dashboard.render.com
- MongoDB Atlas: https://www.mongodb.com/cloud/atlas
- GitHub Docs: https://docs.github.com
- Render Docs: https://render.com/docs

## Notes

- Free tier: Services sleep after 15 minutes of inactivity
- Upgrade to paid for better performance/uptime
- Keep .env file with sensitive data locally (never commit to Git)
- `DEPLOYMENT.md` has detailed instructions for each step
