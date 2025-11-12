# Quick deployment script for Spotto
Write-Host "Spotto Deployment Helper" -ForegroundColor Green
Write-Host ""
Write-Host "Your web build is ready in: build\web" -ForegroundColor Yellow
Write-Host ""
Write-Host "Choose a deployment method:" -ForegroundColor Cyan
Write-Host "1. GitHub Pages (Recommended - Free, reliable)"
Write-Host "2. Firebase Hosting (Requires Firebase account)"
Write-Host "3. Manual upload instructions"
Write-Host ""
Write-Host "For GitHub Pages:" -ForegroundColor Green
Write-Host "1. Go to https://github.com/new"
Write-Host "2. Create a new repository (make it PUBLIC)"
Write-Host "3. Upload the contents of build\web folder"
Write-Host "4. Go to Settings > Pages > Enable GitHub Pages"
Write-Host "5. Your app will be live at: https://YOUR_USERNAME.github.io/REPO_NAME/"
Write-Host ""
Write-Host "For Firebase Hosting:" -ForegroundColor Green
Write-Host "1. Run: firebase login"
Write-Host "2. Run: firebase init hosting (select build/web as public directory)"
Write-Host "3. Run: firebase deploy --only hosting"
Write-Host ""

