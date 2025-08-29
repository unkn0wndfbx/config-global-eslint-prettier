# React Web

Configuration ESLint pour projets React Web uniquement.

## 📁 Contenu

- **`global-eslint.config.mjs`** - Configuration ESLint pour React Web
- **`package-dependencies.json`** - Dépendances npm pour React Web

## 🚀 Utilisation

```bash
# Copier la configuration ESLint
cp global-eslint.config.mjs ../../eslint.config.mjs

# Copier Prettier (dans le dossier shared)
cp ../shared/global-prettier.config.js ../../.prettierrc.js

# Installer les dépendances
npm install --save-dev @eslint/compat @eslint/eslintrc @eslint/js @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-filenames prettier eslint-config-prettier eslint-plugin-prettier
```

## ✨ Fonctionnalités

- Configuration ESLint optimisée pour React Web
- Règles TypeScript strictes
- Support des composants React
- Formatage automatique avec Prettier
- Règles de linting personnalisées
