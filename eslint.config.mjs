import globals from "globals";
import pluginJs from "@eslint/js";
import pluginReact from "eslint-plugin-react";

/** @type {import('eslint').Linter.Config} */
export default {
  files: ["**/*.{js,mjs,cjs,jsx}"],
  languageOptions: {
    globals: globals.browser,
  },
  plugins: {
    js: pluginJs,
    react: pluginReact,
  },
  rules: {
    ...pluginJs.configs.recommended.rules,
    ...pluginReact.configs.recommended.rules,
  },
  settings: {
    react: {
      version: "detect", // Automatically detect the react version
    },
  },
};

if (typeof globalThis.structuredClone === 'undefined') {
  globalThis.structuredClone = structuredClone;
}