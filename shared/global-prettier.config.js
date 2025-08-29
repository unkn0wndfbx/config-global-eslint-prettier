// Configuration Prettier globale pour tous les projets TypeScript/React
// À copier dans chaque projet et adapter selon les besoins

module.exports = {
  // Largeur maximale de ligne (alignée avec ESLint)
  printWidth: 120,

  // Utiliser des espaces au lieu des tabs
  useTabs: false,
  tabWidth: 2,

  // Point-virgule à la fin des lignes
  semi: true,

  // Guillemets simples (plus cohérent avec TypeScript)
  singleQuote: true,
  jsxSingleQuote: true,

  // Pas de virgule finale (aligné avec ESLint)
  trailingComma: 'none',

  // Espaces dans les objets et tableaux
  bracketSpacing: true,

  // Parenthèses des flèches toujours
  arrowParens: 'always',

  // Fin de ligne Unix
  endOfLine: 'lf',

  // Guillemets des propriétés seulement si nécessaire
  quoteProps: 'as-needed',

  // Une propriété par ligne pour JSX (aligné avec ESLint)
  singleAttributePerLine: true,

  // Gestion des espaces HTML
  htmlWhitespaceSensitivity: 'css',

  // Formatage automatique des langages embarqués
  embeddedLanguageFormatting: 'auto',

  // Préserver le wrapping du texte
  proseWrap: 'preserve',

  // Configuration spécifique par type de fichier
  overrides: [
    {
      files: '*.{ts,tsx}',
      options: {
        parser: 'typescript',
        // Règles spécifiques TypeScript
        semi: true,
        singleQuote: true,
        trailingComma: 'none'
      }
    },
    {
      files: '*.{js,jsx}',
      options: {
        parser: 'babel',
        // Règles spécifiques JavaScript
        semi: true,
        singleQuote: true,
        trailingComma: 'none'
      }
    },
    {
      files: '*.json',
      options: {
        parser: 'json',
        // JSON doit avoir des guillemets doubles
        singleQuote: false
      }
    },
    {
      files: '*.md',
      options: {
        parser: 'markdown',
        // Markdown peut avoir des guillemets simples
        singleQuote: true
      }
    },
    {
      files: '*.{yml,yaml}',
      options: {
        parser: 'yaml',
        // YAML peut avoir des guillemets simples
        singleQuote: true
      }
    }
  ]
};
