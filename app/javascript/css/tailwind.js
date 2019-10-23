module.exports = {
  theme: {
    screens: {
      sm: '640px',
      md: '768px',
      lg: '1024px',
      xl: '1280px',
    },
    fontFamily: {
      display: ['Roboto', 'sans-serif'],
      body: ['Roboto', 'sans-serif'],
    },
    extend: {
      colors: {
        cyan: '#DFEFF2',
      },
      spacing: {
        '96': '24rem',
        '128': '32rem',
      },
      minHeight: {
        'task-item': '84px',
      },
      boxShadow: {
        'task-item': '0px 4px 10px rgba(0, 0, 0, 0.25);'
      }
    }
  },
  variants: {},
  plugins: []
}
