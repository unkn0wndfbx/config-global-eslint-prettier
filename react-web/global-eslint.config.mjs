// Configuration ESLint globale pour tous les projets TypeScript/React
// À copier dans chaque projet et adapter selon les besoins

import { fixupPluginRules } from '@eslint/compat';
import { FlatCompat } from '@eslint/eslintrc';
import pluginJs from '@eslint/js';
import typescriptEslint from '@typescript-eslint/eslint-plugin';
import typescriptParser from '@typescript-eslint/parser';
import eslintPluginFilenames from 'eslint-plugin-filenames';
import reactCompilerPlugin from 'eslint-plugin-react-compiler';

const compat = new FlatCompat({
  baseDirectory: process.cwd(),
  resolvePluginsRelativeTo: process.cwd()
});

export default [
  // Base JavaScript recommended rules
  pluginJs.configs.recommended,

  // Convert React Hooks rules
  ...fixupPluginRules(compat.extends('plugin:react-hooks/recommended')),

  // Configuration TypeScript stricte
  {
    files: ['**/*.{ts,tsx}'],
    languageOptions: {
      parser: typescriptParser,
      parserOptions: {
        ecmaVersion: 'latest',
        sourceType: 'module',
        ecmaFeatures: {
          jsx: true
        }
      }
    },
    plugins: {
      '@typescript-eslint': fixupPluginRules(typescriptEslint),
      'react-compiler': fixupPluginRules(reactCompilerPlugin)
    },
    rules: {
      // Règles TypeScript strictes
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/no-unused-vars': [
        'error',
        {
          vars: 'all',
          args: 'after-used',
          ignoreRestSiblings: true,
          varsIgnorePattern: '^_',
          argsIgnorePattern: '^_',
          caughtErrorsIgnorePattern: '^_'
        }
      ],
      'no-unused-vars': 'off',
      'prefer-const': 'error'
    }
  },

  // Configuration générale pour tous les fichiers
  {
    files: ['**/*.{js,mjs,cjs,ts,jsx,tsx}'],
    languageOptions: {
      globals: {
        // Variables globales du navigateur
        window: 'readonly',
        document: 'readonly',
        console: 'readonly',
        setTimeout: 'readonly',
        clearTimeout: 'readonly',
        setInterval: 'readonly',
        clearInterval: 'readonly',
        process: 'readonly',
        global: 'readonly',
        module: 'readonly',
        require: 'readonly',
        exports: 'readonly',
        define: 'readonly',
        AbortController: 'readonly',
        reportError: 'readonly',
        // Variables globales React
        React: 'readonly',
        // Variables globales du navigateur
        localStorage: 'readonly',
        sessionStorage: 'readonly',
        getComputedStyle: 'readonly',
        URL: 'readonly',
        // Variables globales Jest (pour les tests)
        jest: 'readonly',
        describe: 'readonly',
        test: 'readonly',
        it: 'readonly',
        expect: 'readonly',
        beforeEach: 'readonly',
        afterEach: 'readonly',
        beforeAll: 'readonly',
        afterAll: 'readonly',
        // Types DOM
        HTMLElement: 'readonly',
        HTMLDivElement: 'readonly',
        SVGSVGElement: 'readonly',
        HTMLScriptElement: 'readonly'
      }
    },
    plugins: {
      'react-compiler': fixupPluginRules(reactCompilerPlugin)
    },
    rules: {
      // Formatage
      'max-len': [
        'error',
        {
          code: 120,
          ignoreUrls: true,
          ignoreStrings: true,
          ignoreTemplateLiterals: true,
          ignoreRegExpLiterals: true
        }
      ],
      'max-lines': [
        'error',
        {
          max: 1000,
          skipBlankLines: true,
          skipComments: true
        }
      ],
      'no-multiple-empty-lines': [
        'error',
        {
          max: 1,
          maxEOF: 0,
          maxBOF: 0
        }
      ],

      'comma-dangle': 'off',
      curly: 'off',
      camelcase: 'off',
      'no-empty-interface': 'off',
      'no-empty-function': 'off',

      'react-compiler/react-compiler': 'error'
    }
  },

  // Configuration spécifique pour les composants React
  {
    files: ['**/*.{tsx,jsx}'],
    rules: {
      // Règles React
      'react/prop-types': 'off',
      'react/jsx-curly-brace-presence': [
        'error',
        {
          props: 'never',
          children: 'never'
        }
      ]
    }
  },

  // Configuration pour les composants UI (limite de lignes)
  {
    files: ['**/components/**/*.{js,jsx,ts,tsx}', '**/atoms/**/*.{js,jsx,ts,tsx}', '**/molecules/**/*.{js,jsx,ts,tsx}'],
    rules: {
      'max-lines': [
        'error',
        {
          max: 700,
          skipBlankLines: true,
          skipComments: true
        }
      ]
    }
  },

  // Conventions de nommage des fichiers
  {
    files: ['**/*.{js,jsx,ts,tsx}'],
    plugins: {
      filenames: fixupPluginRules(eslintPluginFilenames)
    },
    rules: {
      // Composants en PascalCase
      'filenames/match-regex': ['error', '^[A-Z][a-zA-Z0-9]*$', true]
    }
  },

  // Exceptions pour certains types de fichiers
  {
    files: ['**/index.{js,jsx,ts,tsx}', '**/constants.{js,jsx,ts,tsx}', '**/config.{js,jsx,ts,tsx}'],
    rules: {
      'filenames/match-regex': 'off'
    }
  },

  // Fichiers ignorés
  {
    ignores: [
      'node_modules/*',
      'dist/*',
      'build/*',
      'coverage/*',
      '*.config.{js,ts,mjs}',
      'eslint.config.mjs',
      '**/jest.config.js',
      '**/postcss.config.js',
      '**/webpack.config.js',
      '**/tailwind.config.js',
      '**/bunfig.toml',
      '**/vercel.json',
      '**/.storybook/**'
    ]
  }
];
