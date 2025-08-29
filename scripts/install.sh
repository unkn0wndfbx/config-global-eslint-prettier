#!/bin/bash

# Script d'installation de la configuration globale ESLint + Prettier
# À utiliser depuis le dossier config-global-eslint-prettier

echo "🚀 Installation de la configuration globale ESLint + Prettier..."

# Vérifier si on est dans un projet Node.js
if [ ! -f "package.json" ]; then
    echo "❌ Erreur: Ce script doit être exécuté dans un projet Node.js"
    echo "   Assurez-vous d'être dans le dossier racine de votre projet"
    exit 1
fi

# Créer les dossiers nécessaires
echo "📁 Création des dossiers de configuration..."
mkdir -p .vscode

# Copier les fichiers de configuration
echo "📋 Copie des fichiers de configuration..."

# Configuration ESLint + Prettier (recommandée)
cp "global-eslint-prettier.config.mjs" "eslint.config.mjs"
echo "✅ Configuration ESLint + Prettier copiée"

# Configuration Prettier
cp ".prettierrc" ".prettierrc"
echo "✅ Configuration Prettier copiée"

# Configuration VS Code/Cursor
cp ".vscode/settings.json" ".vscode/settings.json"
cp ".vscode/extensions.json" ".vscode/extensions.json"
echo "✅ Configuration VS Code/Cursor copiée"

# Règles Cursor
cp ".cursorrules" ".cursorrules"
echo "✅ Règles Cursor copiées"

# Installer les dépendances nécessaires
echo "📦 Installation des dépendances..."

# Vérifier si npm ou yarn est disponible
if command -v npm &> /dev/null; then
    PACKAGE_MANAGER="npm"
elif command -v yarn &> /dev/null; then
    PACKAGE_MANAGER="yarn"
else
    echo "❌ Erreur: Aucun gestionnaire de paquets trouvé (npm ou yarn)"
    exit 1
fi

echo "   Utilisation de $PACKAGE_MANAGER"

# Dépendances ESLint
$PACKAGE_MANAGER install --save-dev @eslint/compat @eslint/eslintrc @eslint/js

# Dépendances TypeScript ESLint
$PACKAGE_MANAGER install --save-dev @typescript-eslint/eslint-plugin @typescript-eslint/parser

# Dépendances supplémentaires
$PACKAGE_MANAGER install --save-dev eslint-plugin-filenames

# Dépendances Prettier
$PACKAGE_MANAGER install --save-dev prettier

# Dépendances d'intégration ESLint + Prettier
$PACKAGE_MANAGER install --save-dev eslint-config-prettier eslint-plugin-prettier

echo "✅ Dépendances installées"

# Créer un fichier .prettierignore
echo "📝 Création du fichier .prettierignore..."
cat > .prettierignore << EOF
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
EOF

echo "✅ Fichier .prettierignore créé"

# Créer un fichier .eslintignore
echo "📝 Création du fichier .eslintignore..."
cat > .eslintignore << EOF
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
EOF

echo "✅ Fichier .eslintignore créé"

# Ajouter les scripts dans package.json
echo "📝 Ajout des scripts dans package.json..."

# Vérifier si les scripts existent déjà
if ! grep -q '"lint"' package.json; then
    # Ajouter les scripts de linting
    if [ "$PACKAGE_MANAGER" = "npm" ]; then
        npm pkg set scripts.lint="eslint . --ext .ts,.tsx,.js,.jsx"
        npm pkg set scripts.lint:fix="eslint . --ext .ts,.tsx,.js,.jsx --fix"
        npm pkg set scripts.format="prettier --write ."
        npm pkg set scripts.format:check="prettier --check ."
    else
        # Pour yarn, on doit modifier le fichier directement
        # Ajouter manuellement les scripts
        echo "⚠️  Ajoutez manuellement ces scripts dans package.json:"
        echo "   \"lint\": \"eslint . --ext .ts,.tsx,.js,.jsx\""
        echo "   \"lint:fix\": \"eslint . --ext .ts,.tsx,.js,.jsx --fix\""
        echo "   \"format\": \"prettier --write .\""
        echo "   \"format:check\": \"prettier --check .\""
    fi
    echo "✅ Scripts ajoutés dans package.json"
else
    echo "ℹ️  Scripts de linting déjà présents dans package.json"
fi

# Créer un fichier README pour le projet
echo "📝 Création du fichier README de configuration..."
cat > CONFIGURATION.md << EOF
# Configuration du Projet

Ce projet utilise une configuration globale ESLint + Prettier pour maintenir la qualité du code.

## 🚀 Commandes disponibles

\`\`\`bash
# Linter le code
$PACKAGE_MANAGER run lint

# Corriger automatiquement les erreurs de linting
$PACKAGE_MANAGER run lint:fix

# Formater le code avec Prettier
$PACKAGE_MANAGER run format

# Vérifier le formatage
$PACKAGE_MANAGER run format:check
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
EOF

echo "✅ Fichier CONFIGURATION.md créé"

echo ""
echo "🎉 Configuration terminée avec succès !"
echo ""
echo "📋 Prochaines étapes :"
echo "1. Redémarrez Cursor/VS Code"
echo "2. Installez les extensions recommandées"
echo "3. Testez avec : $PACKAGE_MANAGER run lint"
echo "4. Formatez avec : $PACKAGE_MANAGER run format"
echo ""
echo "✨ Votre code sera maintenant parfaitement formaté et linté !"
