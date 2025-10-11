import { render, screen } from '@testing-library/react';
import App from './App';

test('renders llama vision app', () => {
  render(<App />);
  const titleElement = screen.getByText(/llama vision/i);
  expect(titleElement).toBeInTheDocument();
});