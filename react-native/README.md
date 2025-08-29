# React Native + Expo

Configuration ESLint et outils pour projets React Native avec Expo.

## 📁 Contenu

- **`global-eslint-react-native.config.mjs`** - Configuration ESLint complète pour React Native
- **`package-dependencies-react-native.json`** - Dépendances npm pour React Native
- **`tsconfig-react-native.json`** - Configuration TypeScript optimisée
- **`babel.config.react-native.js`** - Configuration Babel pour Expo

## 🚀 Utilisation

```bash
# Copier la configuration ESLint
cp global-eslint-react-native.config.mjs ../../eslint.config.mjs

# Copier Prettier (dans le dossier shared)
cp ../shared/global-prettier.config.js ../../.prettierrc.js

# Installer les dépendances
npm install --save-dev @eslint/compat @eslint/eslintrc @eslint/js @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-filenames eslint-plugin-react-native prettier eslint-config-prettier eslint-plugin-prettier
```

## ✨ Fonctionnalités

- Support complet React Native + React Web
- Règles ESLint spécifiques React Native
- Configuration TypeScript avec alias de chemins
- Configuration Babel optimisée pour Expo
- Support multi-plateforme
