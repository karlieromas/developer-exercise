import React from 'react';

class QuoteList extends React.Component {

  constructor() {
  super();
    this.state = {
      quotes: []
    };
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
    console.log('state', this.state.quotes);
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
        {this.state.quotes.map(quote => (
          <tr>
            <td>{quote.source}</td>
            <td>{quote.context}</td>
            <td>{quote.quote}</td>
            <td>{quote.theme}</td>
          </tr>
        ))}
        </tbody>
      </table>
    )
  }
}
export default QuoteList