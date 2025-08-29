# Guide de Contribution

Merci de votre intérêt pour contribuer à ce projet de configuration globale ESLint + Prettier !

## 🎯 Comment contribuer

### 📝 **Signaler un bug**

- Utilisez les Issues GitHub
- Décrivez clairement le problème
- Incluez des exemples de code si possible

### 🚀 **Proposer une amélioration**

- Créez une Issue pour discuter de l'amélioration
- Expliquez le bénéfice pour la communauté
- Attendez la validation avant de coder

### 🔧 **Soumettre une correction**

- Fork le projet
- Créez une branche pour votre correction
- Suivez les conventions de code
- Testez vos modifications
- Soumettez une Pull Request

## 📋 Conventions de code

### 🏷️ **Nommage des fichiers**

- **Composants :** PascalCase (`Button.tsx`)
- **Hooks :** camelCase avec préfixe `use` (`useWidgetStatus.ts`)
- **Utilitaires :** camelCase (`date.ts`, `widget.ts`)
- **Types/Interfaces :** camelCase (`restaurant.ts`)

### 📏 **Formatage**

- **Lignes max :** 120 caractères
- **Composants UI :** 700 lignes max
- **Fichiers logique :** 1000 lignes max
- **Espacement :** 1 ligne vide max entre sections

### ✅ **Règles de linting**

- **Interfaces obligatoires** pour les props des composants
- **Exports nommés** pour tous les composants et fonctions
- **Typage explicite** des fonctions et paramètres
- **Pas d'export default** sauf pour constantes/configs

## 🔄 Processus de contribution

### 1. **Fork et Clone**

```bash
git clone https://github.com/votre-username/config-global-eslint-prettier.git
cd config-global-eslint-prettier
```

### 2. **Créer une branche**

```bash
git checkout -b feature/nom-de-la-fonctionnalite
# ou
git checkout -b fix/nom-du-bug
```

### 3. **Développer**

- Respectez les conventions de code
- Testez vos modifications
- Mettez à jour la documentation si nécessaire

### 4. **Tester**

```bash
# Vérifier ESLint
npm run lint

# Vérifier Prettier
npm run format

# Tester sur un projet réel
```

### 5. **Commiter**

```bash
git add .
git commit -m "feat: ajouter nouvelle fonctionnalité"
# ou
git commit -m "fix: corriger bug dans la configuration"
```

### 6. **Pousser et Pull Request**

```bash
git push origin feature/nom-de-la-fonctionnalite
```

## 📚 Structure du projet

### 📁 **Fichiers de configuration**

- `global-eslint.config.mjs` - Configuration React Web
- `global-eslint-react-native.config.mjs` - Configuration React Native
- `global-prettier.config.js` - Configuration Prettier

### 📖 **Documentation**

- `README.md` - Vue d'ensemble principale
- `INSTALLATION.md` - Guide d'installation
- `STRUCTURE.md` - Organisation du projet
- `RESUME.md` - Résumé des améliorations

### 🔧 **Scripts d'installation**

- `install-react-native.ps1` - Windows PowerShell
- `install-react-native.sh` - Linux/Mac Shell
- `install.ps1` et `install.sh` - React Web

## 🧪 Tests

### ✅ **Tests requis**

- ESLint fonctionne sans erreur
- Prettier formate correctement
- Configuration fonctionne sur un projet réel
- Scripts d'installation fonctionnent

### 🔍 **Vérifications**

```bash
# Linter le projet
npm run lint

# Formater le code
npm run format

# Vérifier la structure
npm run lint:check
```

## 📝 Messages de commit

Utilisez le format conventionnel :

- `feat:` - Nouvelle fonctionnalité
- `fix:` - Correction de bug
- `docs:` - Documentation
- `style:` - Formatage
- `refactor:` - Refactoring
- `test:` - Tests
- `chore:` - Maintenance

## 🤝 Code de conduite

- Soyez respectueux et inclusif
- Écoutez les retours de la communauté
- Contribuez de manière constructive
- Respectez les conventions établies

## 📞 Besoin d'aide ?

- Créez une Issue pour les questions
- Consultez la documentation existante
- Rejoignez la communauté

---

**Merci de contribuer à ce projet !** 🎉
