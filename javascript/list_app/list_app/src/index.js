import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import QuoteList from './QuoteList'
import registerServiceWorker from './registerServiceWorker';

ReactDOM.render(<QuoteList />, document.getElementById('root'));
registerServiceWorker();
