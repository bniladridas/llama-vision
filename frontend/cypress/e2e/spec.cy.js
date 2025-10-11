describe('Llama Vision App', () => {
  it('loads the app', () => {
    cy.visit('http://localhost:3000')
    cy.contains('Llama Vision')
  })
})