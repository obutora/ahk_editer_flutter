/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}", "./docs/**/*.{js,jsx,ts,tsx,mdx}", "./docs/*.{js,jsx,ts,tsx,mdx}"],
  theme: {
    fontFamily: {
      'body': ["Helvetica Neue",
        "Hiragino Kaku Gothic ProN",
        "Hiragino Sans",
        'Meiryo',
        'Arial',
        'sans-serif'],
      'mono': ["Helvetica Neue",
        'Arial',
        "Hiragino Kaku Gothic ProN",
        "Hiragino Sans",
        'Meiryo',
        'sans-serif'],
      'sans': ["Helvetica Neue",
        'Arial',
        "Hiragino Kaku Gothic ProN",
        "Hiragino Sans",
        'Meiryo',
        'sans-serif'],
    },
    extend: {},
  },
  plugins: [],
}
