const formPlugin = require('@tailwindcss/forms');

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*',
    './app/components/**/*',
    './app/helpers/**/*',
    './app/frontend/**/*.{js,jsx,ts,tsx}'
  ],
  theme: {
    extend: {}
  },
  plugins: [formPlugin]
};
