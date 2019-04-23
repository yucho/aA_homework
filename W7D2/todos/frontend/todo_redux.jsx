import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

// The following is an anti-pattern
/*
const addLoggingToDispatch = store => {
  const dispatch = store.dispatch;
  return action => {
    console.log('Old state:', store.getState());
    console.log('Action:', action);
    const result = dispatch(action);
    console.log('New state:', store.getState());
    return result;
  }
};
*/

// Below is better, but move it to store/store.js
/*
const addLoggingToDispatch = store => next => action => {
  console.log('Old state:', store.getState());
  console.log('Action:', action);
  next(action);
  console.log('New state:', store.getState());
};
*/

const applyMiddlewares = (store, middlewares) => {
  let dispatch = store.dispatch;
  middlewares.forEach(middleware => {
    dispatch = middleware(store)(dispatch);
  });
  return Object.assign({}, store, { dispatch });
};


document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = configureStore(preloadedState);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
