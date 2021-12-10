import { Route, Routes } from 'react-router-dom';
import AllMeetupsPage from './components/pages/AIIMeetups';
import NewMeetupPage from './components/pages/NewMeetup';
import FavoritesPage from './components/pages/Favorites';
import MainNavigation from './components/layout/MainNavigation'

function App() {
  return (
    <div>
      <MainNavigation>
        <Routes>
          <Route exact path='/'>
            <AllMeetupsPage />
          </Route>
          <Route path='/new'>
            <NewMeetupPage />
          </Route>
          <Route path='/favorites'>
            <FavoritesPage />
          </Route>
        </Routes>
      </MainNavigation>
    </div>
  );
}

export default App;