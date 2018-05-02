import React from 'react';

class QuoteList extends React.Component {

  constructor() {
  super();
    this.state = {
      quotes: [],
      currentPage: 1,
      quotesPerPage: 15
    };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(e) {
    this.setState({
      currentPage: Number(e.target.id)
    });
  }

  componentDidMount() {
    fetch('https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json')
      .then(results => {
        return results.json();
      }).then(data => {
      this.setState({quotes: data});
      })
  }

  render() {
    const { quotes, currentPage, quotesPerPage } = this.state;
      // console.log(currentPage, quotesPerPage);

    const firstOfNextPage = currentPage * quotesPerPage;
      // console.log(indexOfLastQuote);

    const indexOfFirstQuote = firstOfNextPage - quotesPerPage;
    // console.log(indexOfFirstQuote);

    const currentQuotes = quotes.slice(indexOfFirstQuote, firstOfNextPage);
    // console.log(currentQuotes);

    const renderQuotes = currentQuotes.map((quote, index) => {
        return (
          <tr key={index} >
            <td>{quote.source}</td>
            <td>{quote.context}</td>
            <td>{quote.quote}</td>
            <td>{quote.theme}</td>
          </tr>

        );
        });
    // console.log('state', this.state.quotes);
    return (
      <table id='pages' style={{"width":"100%"}}>
        <thead>
          <tr>
            <th>Source</th>
            <th>Context</th>
            <th>Quote</th>
            <th>Theme</th>
          </tr>
        </thead>
        <tbody>
          { renderQuotes }
        </tbody>
      </table>
    )
  }
}
export default QuoteList