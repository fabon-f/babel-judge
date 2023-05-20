import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import lightningcss from 'vite-plugin-lightningcss';

export default defineConfig({
  plugins: [
    RubyPlugin(),
    lightningcss({
      browserslist: '>= 0.25%'
    })
  ]
});
