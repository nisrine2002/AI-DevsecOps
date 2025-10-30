@echo off
REM Security Testing Script for OWASP Juice Shop
echo ========================================
echo AI DevSecOps - Real Project Testing
echo ========================================
echo.

cd juice-shop

echo [1/4] Running SAST scan with Semgrep...
npx semgrep scan --config=auto --json --output=../sast_juice_shop.json .
if %errorlevel% neq 0 (
    echo Warning: Semgrep found issues but continuing...
)
echo SAST scan complete! Report saved to: sast_juice_shop.json
echo.

echo [2/4] Running SCA scan with npm audit...
npm audit --json > ../sca_juice_shop.json 2>&1
echo SCA scan complete! Report saved to: sca_juice_shop.json
echo.

cd ..

echo [3/4] Generating AI-powered security policies...
python ..\backend\orchestrator\policy_generator.py --sast sast_juice_shop.json --sca sca_juice_shop.json --max-per-type 5
echo.

echo [4/4] Testing complete!
echo Check the outputs folder for generated policies.
echo.
pause
