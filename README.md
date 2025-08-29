# Configuration Globale ESLint + Prettier - React & React Native

Configuration ESLint et Prettier unifiée pour projets **React Web** et **React Native avec Expo**, respectant vos règles de linting strictes.

## 🎯 Versions disponibles

### 📱 **React Native avec Expo** (Recommandé pour nouveaux projets)

- Support complet React Native + React Web
- Règles spécifiques React Native
- Structure multi-plateforme
- **Fichier de config :** `global-eslint-react-native.config.mjs`

### 🌐 **React Web uniquement**

- Configuration classique React
- Optimisé pour applications web
- **Fichier de config :** `global-eslint.config.mjs`

## 🚀 Installation Rapide

### 📁 Structure organisée

Le projet est maintenant organisé en dossiers logiques :

- **`react-native/`** - Configuration React Native + Expo
- **`react-web/`** - Configuration React Web uniquement
- **`shared/`** - Configuration Prettier commune
- **`scripts/`** - Scripts d'installation automatisés
- **`.vscode/`** - Configuration VSCode/Cursor

Chaque dossier contient son propre README avec des instructions détaillées.

### Pour React Native + Expo (Recommandé)

```bash
# 1. Copier la configuration React Native
cp react-native/global-eslint-react-native.config.mjs eslint.config.mjs

# 2. Copier Prettier
cp shared/global-prettier.config.js .prettierrc.js

# 3. Installer les dépendances
npm install --save-dev @eslint/compat @eslint/eslintrc @eslint/js @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-filenames eslint-plugin-react-native prettier eslint-config-prettier eslint-plugin-prettier

# 4. Ajouter les scripts dans package.json
```

### Pour React Web uniquement

```bash
# 1. Copier la configuration React
cp react-web/global-eslint.config.mjs eslint.config.mjs

# 2. Copier Prettier
cp shared/global-prettier.config.js .prettierrc.js

# 3. Installer les dépendances
npm install --save-dev @eslint/compat @eslint/eslintrc @eslint/js @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-filenames prettier eslint-config-prettier eslint-plugin-prettier
```

## 📋 Scripts package.json

```json
{
  "scripts": {
    "lint": "eslint . --ext .ts,.tsx,.js,.jsx",
    "lint:fix": "eslint . --ext .ts,.tsx,.js,.jsx --fix",
    "format": "prettier --write .",
    "format:check": "prettier --check ."
  }
}
```

**Scripts supplémentaires pour React Native :**

```json
{
  "scripts": {
    "lint:web": "eslint src/web --ext .ts,.tsx,.js,.jsx",
    "lint:native": "eslint src/native --ext .ts,.tsx,.js,.jsx"
  }
}
```

## 🔧 Configuration VSCode/Cursor

### settings.json

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ]
}
```

### Extensions requises

- ESLint
- Prettier - Code formatter

## 📁 Structure de projet recommandée

### Pour React Native + Expo

```
src/
├── shared/           # Code partagé
├── web/              # Code Web uniquement
└── native/           # Code React Native uniquement
```

### Pour React Web uniquement

```
src/
├── components/
├── hooks/
├── pages/
└── utils/
```

## 🎨 Règles de linting appliquées

### ✅ Règles principales

- **Interfaces obligatoires** pour les props des composants
- **Exports nommés** pour tous les composants et fonctions
- **Typage explicite** des fonctions et paramètres
- **Pas d'export default** sauf pour constantes/configs
- **Formatage automatique** avec Prettier

### 📏 Limites de code

- **Lignes max :** 120 caractères
- **Composants UI :** 700 lignes max
- **Fichiers logique :** 1000 lignes max
- **Espacement :** 1 ligne vide max entre sections

### 🏷️ Conventions de nommage

- **Composants :** PascalCase (`Button.tsx`)
- **Hooks :** camelCase avec préfixe `use` (`useWidgetStatus.ts`)
- **Utilitaires :** camelCase (`date.ts`, `widget.ts`)
- **Types/Interfaces :** camelCase (`restaurant.ts`)

## 🚀 Commandes utiles

```bash
# Linting
npm run lint          # Linter tout le projet
npm run lint:fix      # Corriger automatiquement

# Formatage
npm run format        # Formater tout le projet
npm run format:check  # Vérifier le formatage

# React Native spécifique
npm run lint:web      # Linter seulement le code Web
npm run lint:native   # Linter seulement le code Native
```

## 📱 Support multi-plateforme (React Native)

### Démarrage

```bash
npm start          # Démarrer Expo
npm run android    # Démarrer sur Android
npm run ios        # Démarrer sur iOS
npm run web        # Démarrer sur Web
```

### Gestion conditionnelle

```typescript
import { Platform } from "react-native";

if (Platform.OS === "web") {
  // Code spécifique au Web
} else {
  // Code spécifique au mobile
}
```

## 🔧 Scripts d'installation automatique

### Windows PowerShell

```powershell
.\scripts\install-react-native.ps1    # React Native + Expo
.\scripts\install.ps1                 # React Web uniquement
```

### Linux/Mac Shell

```bash
./scripts/install-react-native.sh     # React Native + Expo
./scripts/install.sh                  # React Web uniquement
```

## 📁 Organisation des fichiers

```
config-global-eslint-prettier/
├── 📖 README.md                        # Ce fichier - Vue d'ensemble complète
├── 🤝 CONTRIBUTING.md                  # Guide de contribution (GitHub)
├── 📄 LICENSE                          # Licence MIT
├── 🚫 .gitignore                       # Fichiers ignorés
│
├── 📱 react-native/                    # Configuration React Native + Expo
│   ├── global-eslint-react-native.config.mjs
│   ├── package-dependencies-react-native.json
│   ├── tsconfig-react-native.json
│   └── babel.config.react-native.js
│
├── 🌐 react-web/                       # Configuration React Web
│   ├── global-eslint.config.mjs
│   └── package-dependencies.json
│
├── 🎨 shared/                          # Configuration partagée
│   └── global-prettier.config.js
│
├── 🔧 scripts/                         # Scripts d'installation
│   ├── install-react-native.ps1        # Windows
│   ├── install-react-native.sh         # Linux/Mac
│   ├── install.ps1                     # React Web Windows
│   └── install.sh                      # React Web Linux/Mac
│
└── ⚙️ .vscode/                         # Configuration VSCode/Cursor
    ├── settings.json
    └── extensions.json
```

## 🐛 Résolution des problèmes

### ESLint ne fonctionne pas

- Vérifiez que `eslint.config.mjs` est à la racine
- Vérifiez que les extensions VSCode sont installées
- Relancez VSCode/Cursor après installation

### Prettier ne fonctionne pas

- Vérifiez que `.prettierrc.js` est à la racine
- Vérifiez que l'extension Prettier est installée
- Vérifiez les paramètres `formatOnSave`

## 🎯 Choisir sa version

### Choisir React Native + Expo si :

- ✅ Vous voulez développer pour mobile ET web
- ✅ Vous utilisez ou prévoyez d'utiliser Expo
- ✅ Vous voulez une structure évolutive
- ✅ Vous débutez un nouveau projet

### Choisir React Web uniquement si :

- ✅ Votre projet est uniquement web
- ✅ Vous n'avez pas besoin de mobile
- ✅ Vous voulez une configuration plus simple

## 🔄 Migration

### De React Web vers React Native

1. Sauvegardez votre configuration actuelle
2. Copiez `react-native/global-eslint-react-native.config.mjs`
3. Installez `eslint-plugin-react-native`
4. Adaptez votre structure de projet

### De React Native vers React Web

1. Sauvegardez votre configuration actuelle
2. Copiez `react-web/global-eslint.config.mjs`
3. Supprimez `eslint-plugin-react-native`
4. Simplifiez votre structure de projet

## 📞 Support

Pour toute question ou problème :

1. Vérifiez ce README
2. Consultez les exemples de code
3. Vérifiez la configuration VSCode/Cursor

---

**💡 Conseil :** Commencez avec la version React Native + Expo même si vous n'avez pas besoin de mobile immédiatement. Cela vous donnera une base solide pour l'avenir !
