#!/bin/bash

# Script d'installation automatique pour React Native avec Expo
# Configuration ESLint + Prettier globale

echo "🚀 Installation de la configuration ESLint + Prettier React Native avec Expo"
echo ""

# Vérifier si on est dans un projet npm
if [ ! -f "package.json" ]; then
    echo "❌ Erreur: package.json non trouvé. Exécutez ce script dans un projet npm."
    exit 1
fi

# Vérifier si c'est un projet Expo
isExpo=false
if [ -f "app.json" ]; then
    if grep -q "expo" app.json; then
        isExpo=true
        echo "✅ Projet Expo détecté"
    fi
fi

if [ "$isExpo" = false ]; then
    echo "⚠️  Attention: Ce projet ne semble pas être un projet Expo."
    echo "   La configuration fonctionnera mais certaines fonctionnalités React Native pourraient ne pas être optimales."
    echo ""
fi

# Copier les fichiers de configuration
echo "📁 Copie des fichiers de configuration..."

# Copier ESLint React Native
if [ -f "global-eslint-react-native.config.mjs" ]; then
    cp global-eslint-react-native.config.mjs eslint.config.mjs
    echo "   ✅ eslint.config.mjs copié"
else
    echo "   ❌ global-eslint-react-native.config.mjs non trouvé"
    exit 1
fi

# Copier Prettier
if [ -f "global-prettier.config.js" ]; then
    cp global-prettier.config.js .prettierrc.js
    echo "   ✅ .prettierrc.js copié"
else
    echo "   ❌ global-prettier.config.js non trouvé"
    exit 1
fi

# Copier les dépendances
if [ -f "package-dependencies-react-native.json" ]; then
    cp package-dependencies-react-native.json package-dependencies.json
    echo "   ✅ package-dependencies.json copié"
else
    echo "   ❌ package-dependencies-react-native.json non trouvé"
    exit 1
fi

echo ""

# Installer les dépendances
echo "📦 Installation des dépendances..."

# Installer les dépendances principales
echo "   📥 Installation des packages ESLint..."
npm install --save-dev @eslint/compat @eslint/eslintrc @eslint/js @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-filenames eslint-plugin-react-native prettier eslint-config-prettier eslint-plugin-prettier

if [ $? -eq 0 ]; then
    echo "   ✅ Dépendances installées avec succès"
else
    echo "   ❌ Erreur lors de l'installation des dépendances"
    exit 1
fi

echo ""

# Ajouter les scripts dans package.json
echo "📝 Mise à jour du package.json..."

# Créer un fichier temporaire avec les nouveaux scripts
cat > package.json.tmp << 'EOF'
{
  "scripts": {
    "lint": "eslint . --ext .ts,.tsx,.js,.jsx",
    "lint:fix": "eslint . --ext .ts,.tsx,.js,.jsx --fix",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "lint:web": "eslint src/web --ext .ts,.tsx,.js,.jsx",
    "lint:native": "eslint src/native --ext .ts,.tsx,.js,.jsx"
  }
}
EOF

# Fusionner avec le package.json existant (approche simple)
if command -v jq &> /dev/null; then
    # Utiliser jq si disponible
    jq -s '.[0] * .[1]' package.json package.json.tmp > package.json.new
    mv package.json.new package.json
    echo "   ✅ Scripts ajoutés dans package.json (avec jq)"
else
    # Approche manuelle si jq n'est pas disponible
    echo "   ⚠️  jq non disponible, ajoutez manuellement les scripts de linting"
    echo "   📝 Scripts à ajouter :"
    cat package.json.tmp
fi

rm package.json.tmp

echo ""

# Créer la structure de dossiers recommandée
echo "📁 Création de la structure de dossiers recommandée..."

folders=(
    "src"
    "src/shared"
    "src/shared/components"
    "src/shared/hooks"
    "src/shared/types"
    "src/shared/utils"
    "src/shared/constants"
    "src/web"
    "src/native"
)

for folder in "${folders[@]}"; do
    if [ ! -d "$folder" ]; then
        mkdir -p "$folder"
        echo "   📁 Créé: $folder"
    else
        echo "   ✅ Existe déjà: $folder"
    fi
done

echo ""

# Créer des fichiers d'exemple
echo "📄 Création de fichiers d'exemple..."

# Fichier d'entrée principal
cat > src/index.ts << 'EOF'
// Point d'entrée principal - Support multi-plateforme
import { Platform } from 'react-native';

if (Platform.OS === 'web') {
  require('./web/App');
} else {
  require('./native/App');
}
EOF
echo "   📄 Créé: src/index.ts"

# App Web
cat > src/web/App.tsx << 'EOF'
// Application Web
import React from 'react';

export const App: React.FC = () => {
  return (
    <div>
      <h1>Mon App Web</h1>
    </div>
  );
};
EOF
echo "   📄 Créé: src/web/App.tsx"

# App Native
cat > src/native/App.tsx << 'EOF'
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
EOF
echo "   📄 Créé: src/native/App.tsx"

# Composant partagé
cat > src/shared/components/Button.tsx << 'EOF'
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
EOF
echo "   📄 Créé: src/shared/components/Button.tsx"

echo ""

# Créer .eslintignore
echo "📝 Création de .eslintignore..."

cat > .eslintignore << 'EOF'
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
EOF
echo "   ✅ .eslintignore créé"

echo ""

# Test de la configuration
echo "🧪 Test de la configuration..."

# Test ESLint
echo "   🔍 Test ESLint..."
npm run lint > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "   ✅ ESLint fonctionne correctement"
else
    echo "   ⚠️  ESLint a des avertissements (normal pour un nouveau projet)"
fi

# Test Prettier
echo "   🎨 Test Prettier..."
npm run format > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "   ✅ Prettier fonctionne correctement"
else
    echo "   ⚠️  Prettier a des avertissements (normal pour un nouveau projet)"
fi

echo ""

# Instructions finales
echo "🎉 Installation terminée avec succès !"
echo ""
echo "📋 Prochaines étapes :"
echo "   1. Configurez VSCode/Cursor avec les extensions ESLint et Prettier"
echo "   2. Ajoutez dans settings.json :"
echo "      {"
echo "        \"editor.formatOnSave\": true,"
echo "        \"editor.defaultFormatter\": \"esbenp.prettier-vscode\""
echo "      }"
echo "   3. Relancez VSCode/Cursor"
echo "   4. Commencez à développer !"
echo ""
echo "🚀 Commandes disponibles :"
echo "   npm run lint          # Linter le projet"
echo "   npm run lint:fix      # Corriger automatiquement"
echo "   npm run format        # Formater le code"
echo "   npm start             # Démarrer Expo"
echo ""
echo "📚 Documentation :"
echo "   - README-UNIFIE.md pour la vue d'ensemble"
echo "   - INSTALLATION-REACT-NATIVE.md pour les détails"
echo "   - expo-project-structure.md pour la structure"
echo ""
echo "✨ Bon développement !"
