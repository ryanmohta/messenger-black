const Dotenv = require('dotenv-webpack');

module.exports = {
  entry: {
    background: './background.js',
    script: './script.js'
  },
  output: {
    filename: '[name].js'
  },
  plugins: [
    new Dotenv()
  ]
};
