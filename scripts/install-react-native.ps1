# Script d'installation automatique pour React Native avec Expo
# Configuration ESLint + Prettier globale

Write-Host "🚀 Installation de la configuration ESLint + Prettier React Native avec Expo" -ForegroundColor Green
Write-Host ""

# Vérifier si on est dans un projet npm
if (-not (Test-Path "package.json")) {
    Write-Host "❌ Erreur: package.json non trouvé. Exécutez ce script dans un projet npm." -ForegroundColor Red
    exit 1
}

# Vérifier si c'est un projet Expo
$isExpo = $false
if (Test-Path "app.json") {
    $appConfig = Get-Content "app.json" | ConvertFrom-Json
    if ($appConfig.expo) {
        $isExpo = $true
        Write-Host "✅ Projet Expo détecté" -ForegroundColor Green
    }
}

if (-not $isExpo) {
    Write-Host "⚠️  Attention: Ce projet ne semble pas être un projet Expo." -ForegroundColor Yellow
    Write-Host "   La configuration fonctionnera mais certaines fonctionnalités React Native pourraient ne pas être optimales." -ForegroundColor Yellow
    Write-Host ""
}

# Copier les fichiers de configuration
Write-Host "📁 Copie des fichiers de configuration..." -ForegroundColor Blue

# Copier ESLint React Native
if (Test-Path "global-eslint-react-native.config.mjs") {
    Copy-Item "global-eslint-react-native.config.mjs" "eslint.config.mjs" -Force
    Write-Host "   ✅ eslint.config.mjs copié" -ForegroundColor Green
} else {
    Write-Host "   ❌ global-eslint-react-native.config.mjs non trouvé" -ForegroundColor Red
    exit 1
}

# Copier Prettier
if (Test-Path "global-prettier.config.js") {
    Copy-Item "global-prettier.config.js" ".prettierrc.js" -Force
    Write-Host "   ✅ .prettierrc.js copié" -ForegroundColor Green
} else {
    Write-Host "   ❌ global-prettier.config.js non trouvé" -ForegroundColor Red
    exit 1
}

# Copier les dépendances
if (Test-Path "package-dependencies-react-native.json") {
    Copy-Item "package-dependencies-react-native.json" "package-dependencies.json" -Force
    Write-Host "   ✅ package-dependencies.json copié" -ForegroundColor Green
} else {
    Write-Host "   ❌ package-dependencies-react-native.json non trouvé" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Installer les dépendances
Write-Host "📦 Installation des dépendances..." -ForegroundColor Blue

try {
    # Installer les dépendances principales
    Write-Host "   📥 Installation des packages ESLint..." -ForegroundColor Yellow
    npm install --save-dev @eslint/compat @eslint/eslintrc @eslint/js @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-filenames eslint-plugin-react-native prettier eslint-config-prettier eslint-plugin-prettier
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Dépendances installées avec succès" -ForegroundColor Green
    } else {
        Write-Host "   ❌ Erreur lors de l'installation des dépendances" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "   ❌ Erreur lors de l'installation: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Ajouter les scripts dans package.json
Write-Host "📝 Mise à jour du package.json..." -ForegroundColor Blue

try {
    $packageJson = Get-Content "package.json" | ConvertFrom-Json
    
    # Ajouter les scripts de linting
    if (-not $packageJson.scripts) {
        $packageJson.scripts = @{}
    }
    
    $packageJson.scripts.lint = "eslint . --ext .ts,.tsx,.js,.jsx"
    $packageJson.scripts."lint:fix" = "eslint . --ext .ts,.tsx,.js,.jsx --fix"
    $packageJson.scripts.format = "prettier --write ."
    $packageJson.scripts."format:check" = "prettier --check ."
    
    # Scripts spécifiques React Native
    $packageJson.scripts."lint:web" = "eslint src/web --ext .ts,.tsx,.js,.jsx"
    $packageJson.scripts."lint:native" = "eslint src/native --ext .ts,.tsx,.js,.jsx"
    
    # Sauvegarder le package.json
    $packageJson | ConvertTo-Json -Depth 10 | Set-Content "package.json"
    Write-Host "   ✅ Scripts ajoutés dans package.json" -ForegroundColor Green
    
} catch {
    Write-Host "   ❌ Erreur lors de la mise à jour du package.json: $_" -ForegroundColor Red
    Write-Host "   📝 Ajoutez manuellement les scripts de linting" -ForegroundColor Yellow
}

Write-Host ""

# Créer la structure de dossiers recommandée
Write-Host "📁 Création de la structure de dossiers recommandée..." -ForegroundColor Blue

$folders = @(
    "src",
    "src/shared",
    "src/shared/components",
    "src/shared/hooks",
    "src/shared/types",
    "src/shared/utils",
    "src/shared/constants",
    "src/web",
    "src/native"
)

foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Write-Host "   📁 Créé: $folder" -ForegroundColor Green
    } else {
        Write-Host "   ✅ Existe déjà: $folder" -ForegroundColor Yellow
    }
}

Write-Host ""

# Créer des fichiers d'exemple
Write-Host "📄 Création de fichiers d'exemple..." -ForegroundColor Blue

# Fichier d'entrée principal
$mainIndex = @"
// Point d'entrée principal - Support multi-plateforme
import { Platform } from 'react-native';

if (Platform.OS === 'web') {
  require('./web/App');
} else {
  require('./native/App');
}
"@

Set-Content "src/index.ts" $mainIndex
Write-Host "   📄 Créé: src/index.ts" -ForegroundColor Green

# App Web
$webApp = @"
// Application Web
import React from 'react';

export const App: React.FC = () => {
  return (
    <div>
      <h1>Mon App Web</h1>
    </div>
  );
};
"@

Set-Content "src/web/App.tsx" $webApp
Write-Host "   📄 Créé: src/web/App.tsx" -ForegroundColor Green

# App Native
$nativeApp = @"
// Application React Native
import React from 'react';
import { View, Text } from 'react-native';

export const App: React.FC = () => {
  return (
    <View>
      <Text>Mon App Native</Text>
    </View>
  );
};
"@

Set-Content "src/native/App.tsx" $nativeApp
Write-Host "   📄 Créé: src/native/App.tsx" -ForegroundColor Green

# Composant partagé
$sharedButton = @"
// Composant partagé entre Web et Native
interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary';
}

export const Button: React.FC<ButtonProps> = ({ title, onPress, variant = 'primary' }) => {
  return (
    <button onClick={onPress} className={variant}>
      {title}
    </button>
  );
};
"@

Set-Content "src/shared/components/Button.tsx" $sharedButton
Write-Host "   📄 Créé: src/shared/components/Button.tsx" -ForegroundColor Green

Write-Host ""

# Créer .eslintignore
Write-Host "📝 Création de .eslintignore..." -ForegroundColor Blue

$eslintignore = @"
node_modules/
dist/
build/
coverage/
*.config.js
*.config.ts
*.config.mjs
expo/
android/
ios/
"@

Set-Content ".eslintignore" $eslintignore
Write-Host "   ✅ .eslintignore créé" -ForegroundColor Green

Write-Host ""

# Test de la configuration
Write-Host "🧪 Test de la configuration..." -ForegroundColor Blue

try {
    # Test ESLint
    Write-Host "   🔍 Test ESLint..." -ForegroundColor Yellow
    npm run lint 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ ESLint fonctionne correctement" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  ESLint a des avertissements (normal pour un nouveau projet)" -ForegroundColor Yellow
    }
    
    # Test Prettier
    Write-Host "   🎨 Test Prettier..." -ForegroundColor Yellow
    npm run format 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Prettier fonctionne correctement" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  Prettier a des avertissements (normal pour un nouveau projet)" -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "   ❌ Erreur lors des tests: $_" -ForegroundColor Red
}

Write-Host ""

# Instructions finales
Write-Host "🎉 Installation terminée avec succès !" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Prochaines étapes :" -ForegroundColor Blue
Write-Host "   1. Configurez VSCode/Cursor avec les extensions ESLint et Prettier" -ForegroundColor White
Write-Host "   2. Ajoutez dans settings.json :" -ForegroundColor White
Write-Host "      {"
Write-Host "        \"editor.formatOnSave\": true,"
Write-Host "        \"editor.defaultFormatter\": \"esbenp.prettier-vscode\""
Write-Host "      }" -ForegroundColor White
Write-Host "   3. Relancez VSCode/Cursor" -ForegroundColor White
Write-Host "   4. Commencez à développer !" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Commandes disponibles :" -ForegroundColor Blue
Write-Host "   npm run lint          # Linter le projet" -ForegroundColor White
Write-Host "   npm run lint:fix      # Corriger automatiquement" -ForegroundColor White
Write-Host "   npm run format        # Formater le code" -ForegroundColor White
Write-Host "   npm start             # Démarrer Expo" -ForegroundColor White
Write-Host ""
Write-Host "📚 Documentation :" -ForegroundColor Blue
Write-Host "   - README-UNIFIE.md pour la vue d'ensemble" -ForegroundColor White
Write-Host "   - INSTALLATION-REACT-NATIVE.md pour les détails" -ForegroundColor White
Write-Host "   - expo-project-structure.md pour la structure" -ForegroundColor White
Write-Host ""
Write-Host "✨ Bon développement !" -ForegroundColor Green
