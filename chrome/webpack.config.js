const Dotenv = require('dotenv-webpack');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  entry: { background: './background.js', script: './script.js', styles: '../styles.css' },
  module: { rules: [{ test: /\.css$/i, use: [MiniCssExtractPlugin.loader, "css-loader"] }] },
  plugins: [new Dotenv(), new MiniCssExtractPlugin()]
};
