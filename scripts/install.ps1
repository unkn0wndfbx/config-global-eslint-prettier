# Script d'installation de la configuration globale ESLint + Prettier
# Pour Windows PowerShell

Write-Host "🚀 Installation de la configuration globale ESLint + Prettier..." -ForegroundColor Green

# Vérifier si on est dans un projet Node.js
if (-not (Test-Path "package.json")) {
    Write-Host "❌ Erreur: Ce script doit être exécuté dans un projet Node.js" -ForegroundColor Red
    Write-Host "   Assurez-vous d'être dans le dossier racine de votre projet" -ForegroundColor Yellow
    exit 1
}

# Créer les dossiers nécessaires
Write-Host "📁 Création des dossiers de configuration..." -ForegroundColor Blue
New-Item -ItemType Directory -Force -Path ".vscode" | Out-Null

# Copier les fichiers de configuration
Write-Host "📋 Copie des fichiers de configuration..." -ForegroundColor Blue

# Configuration ESLint + Prettier (recommandée)
Copy-Item "global-eslint-prettier.config.mjs" "eslint.config.mjs" -Force
Write-Host "✅ Configuration ESLint + Prettier copiée" -ForegroundColor Green

# Configuration Prettier
Copy-Item ".prettierrc" ".prettierrc" -Force
Write-Host "✅ Configuration Prettier copiée" -ForegroundColor Green

# Configuration VS Code/Cursor
Copy-Item ".vscode/settings.json" ".vscode/settings.json" -Force
Copy-Item ".vscode/extensions.json" ".vscode/extensions.json" -Force
Write-Host "✅ Configuration VS Code/Cursor copiée" -ForegroundColor Green

# Règles Cursor
Copy-Item ".cursorrules" ".cursorrules" -Force
Write-Host "✅ Règles Cursor copiées" -ForegroundColor Green

# Installer les dépendances nécessaires
Write-Host "📦 Installation des dépendances..." -ForegroundColor Blue

# Vérifier si npm ou yarn est disponible
$packageManager = $null
if (Get-Command npm -ErrorAction SilentlyContinue) {
    $packageManager = "npm"
} elseif (Get-Command yarn -ErrorAction SilentlyContinue) {
    $packageManager = "yarn"
} else {
    Write-Host "❌ Erreur: Aucun gestionnaire de paquets trouvé (npm ou yarn)" -ForegroundColor Red
    exit 1
}

Write-Host "   Utilisation de $packageManager" -ForegroundColor Cyan

# Dépendances ESLint
& $packageManager install --save-dev @eslint/compat @eslint/eslintrc @eslint/js

# Dépendances TypeScript ESLint
& $packageManager install --save-dev @typescript-eslint/eslint-plugin @typescript-eslint/parser

# Dépendances supplémentaires
& $packageManager install --save-dev eslint-plugin-filenames

# Dépendances Prettier
& $packageManager install --save-dev prettier

# Dépendances d'intégration ESLint + Prettier
& $packageManager install --save-dev eslint-config-prettier eslint-plugin-prettier

Write-Host "✅ Dépendances installées" -ForegroundColor Green

# Créer un fichier .prettierignore
Write-Host "📝 Création du fichier .prettierignore..." -ForegroundColor Blue
@"
# Dossiers
node_modules/
dist/
build/
coverage/
.next/
out/

# Fichiers
*.log
*.lock
.env*
.DS_Store
Thumbs.db

# Fichiers de configuration
package-lock.json
yarn.lock
pnpm-lock.yaml
"@ | Out-File -FilePath ".prettierignore" -Encoding UTF8

Write-Host "✅ Fichier .prettierignore créé" -ForegroundColor Green

# Créer un fichier .eslintignore
Write-Host "📝 Création du fichier .eslintignore..." -ForegroundColor Blue
@"
# Dossiers
node_modules/
dist/
build/
coverage/
.next/
out/

# Fichiers
*.log
*.lock
.env*
.DS_Store
Thumbs.db

# Fichiers de configuration
package-lock.json
yarn.lock
pnpm-lock.yaml
"@ | Out-File -FilePath ".eslintignore" -Encoding UTF8

Write-Host "✅ Fichier .eslintignore créé" -ForegroundColor Green

# Ajouter les scripts dans package.json
Write-Host "📝 Ajout des scripts dans package.json..." -ForegroundColor Blue

# Vérifier si les scripts existent déjà
$packageJson = Get-Content "package.json" | ConvertFrom-Json
if (-not $packageJson.scripts.PSObject.Properties.Name -contains "lint") {
    # Ajouter les scripts de linting
    if ($packageManager -eq "npm") {
        npm pkg set scripts.lint="eslint . --ext .ts,.tsx,.js,.jsx"
        npm pkg set scripts.lint:fix="eslint . --ext .ts,.tsx,.js,.jsx --fix"
        npm pkg set scripts.format="prettier --write ."
        npm pkg set scripts.format:check="prettier --check ."
        Write-Host "✅ Scripts ajoutés dans package.json" -ForegroundColor Green
    } else {
        # Pour yarn, on doit modifier le fichier directement
        Write-Host "⚠️  Ajoutez manuellement ces scripts dans package.json:" -ForegroundColor Yellow
        Write-Host "   `"lint`": `"eslint . --ext .ts,.tsx,.js,.jsx`"" -ForegroundColor Cyan
        Write-Host "   `"lint:fix`": `"eslint . --ext .ts,.tsx,.js,.jsx --fix`"" -ForegroundColor Cyan
        Write-Host "   `"format`": `"prettier --write .`"" -ForegroundColor Cyan
        Write-Host "   `"format:check`": `"prettier --check .`"" -ForegroundColor Cyan
    }
} else {
    Write-Host "ℹ️  Scripts de linting déjà présents dans package.json" -ForegroundColor Yellow
}

# Créer un fichier README pour le projet
Write-Host "📝 Création du fichier CONFIGURATION.md..." -ForegroundColor Blue
@"
# Configuration du Projet

Ce projet utilise une configuration globale ESLint + Prettier pour maintenir la qualité du code.

## 🚀 Commandes disponibles

\`\`\`bash
# Linter le code
$packageManager run lint

# Corriger automatiquement les erreurs de linting
$packageManager run lint:fix

# Formater le code avec Prettier
$packageManager run format

# Vérifier le formatage
$packageManager run format:check
\`\`\`

## 🔧 Configuration

- **ESLint**: \`eslint.config.mjs\`
- **Prettier**: \`.prettierrc\`
- **VS Code/Cursor**: \`.vscode/settings.json\`
- **Règles Cursor**: \`.cursorrules\`

## 📋 Extensions recommandées

Installez les extensions VS Code/Cursor recommandées dans \`.vscode/extensions.json\`

## 🎯 Règles principales

- Interfaces obligatoires pour les props des composants
- Exports nommés (pas d'export default sauf pour constantes)
- Typage explicite des fonctions et paramètres
- Formatage automatique à la sauvegarde
- Longueur de ligne maximale : 120 caractères

## 🌟 Formatage automatique

- **Formatage à la sauvegarde** : Activé avec Prettier
- **Correction ESLint** : Automatique à la sauvegarde
- **Organisation des imports** : Automatique à la sauvegarde
"@ | Out-File -FilePath "CONFIGURATION.md" -Encoding UTF8

Write-Host "✅ Fichier CONFIGURATION.md créé" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Configuration terminée avec succès !" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Prochaines étapes :" -ForegroundColor Cyan
Write-Host "1. Redémarrez Cursor/VS Code" -ForegroundColor White
Write-Host "2. Installez les extensions recommandées" -ForegroundColor White
Write-Host "3. Testez avec : $packageManager run lint" -ForegroundColor White
Write-Host "4. Formatez avec : $packageManager run format" -ForegroundColor White
Write-Host ""
Write-Host "✨ Votre code sera maintenant parfaitement formaté et linté !" -ForegroundColor Green
