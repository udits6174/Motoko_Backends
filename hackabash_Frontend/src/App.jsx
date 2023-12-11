import './App.css'
import { Route, Routes } from 'react-router-dom'
import Navbar from './components/Navbar'
import Register from './pages/Register'
import ListForm from './pages/ListForm'
import Homepage from './pages/Homepage'
import ErrorComponent from './pages/ErrorComponent'

function App() {
  return (
    <>
    <Navbar />
      <Routes>
        <Route path='/' element={<Homepage/>}/>
        <Route path="/register" element={<Register />} />
        <Route path="/organise" element={<ListForm />} />
        <Route path="*" element={<ErrorComponent />} />
      </Routes>
    </>
  )
}

export default App
