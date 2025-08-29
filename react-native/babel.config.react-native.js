module.exports = function (api) {
  api.cache(true);

  return {
    presets: [['babel-preset-expo', { jsxImportSource: 'react' }]],
    plugins: [
      // Support des alias de chemins
      [
        'module-resolver',
        {
          root: ['./src'],
          alias: {
            '@': './src',
            '@/shared': './src/shared',
            '@/web': './src/web',
            '@/native': './src/native',
            '@/components': './src/shared/components',
            '@/hooks': './src/shared/hooks',
            '@/types': './src/shared/types',
            '@/utils': './src/shared/utils',
            '@/constants': './src/shared/constants'
          }
        }
      ],
      // Support des re-exports
      'babel-plugin-transform-export-extensions',
      // Support des décorateurs
      ['@babel/plugin-proposal-decorators', { legacy: true }],
      // Support des propriétés de classe
      '@babel/plugin-proposal-class-properties',
      // Support des propriétés privées
      '@babel/plugin-proposal-private-methods',
      // Support des propriétés privées avec #
      '@babel/plugin-proposal-private-property-in-object'
    ],
    env: {
      production: {
        plugins: ['transform-remove-console', 'transform-remove-debugger']
      }
    }
  };
};
