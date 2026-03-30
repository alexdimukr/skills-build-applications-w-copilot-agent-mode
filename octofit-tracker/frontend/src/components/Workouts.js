import React, { useState, useEffect } from 'react';
import { fetchData } from '../api/api';

const Workouts = () => {
  const [workouts, setWorkouts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadWorkouts = async () => {
      try {
        console.log('💪 Loading Workouts component...');
        setLoading(true);
        const data = await fetchData('/api/workouts/');
        console.log('💪 Workouts loaded successfully:', data);
        setWorkouts(data);
      } catch (err) {
        console.error('❌ Failed to load workouts:', err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    loadWorkouts();
  }, []);

  if (loading) return <div className="alert alert-info">Loading workouts...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <div className="container mt-4">
      <h2>Workouts</h2>
      {workouts.length === 0 ? (
        <div className="alert alert-warning">No workouts found</div>
      ) : (
        <div className="table-responsive">
          <table className="table table-striped table-hover">
            <thead className="table-dark">
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Type</th>
                <th>Duration</th>
                <th>Difficulty</th>
                <th>Created Date</th>
              </tr>
            </thead>
            <tbody>
              {workouts.map((workout) => (
                <tr key={workout.id}>
                  <td>{workout.id}</td>
                  <td>{workout.name || 'N/A'}</td>
                  <td>{workout.type || 'N/A'}</td>
                  <td>{workout.duration || 'N/A'} min</td>
                  <td>
                    <span className="badge bg-info">{workout.difficulty || 'N/A'}</span>
                  </td>
                  <td>{workout.created_at ? new Date(workout.created_at).toLocaleDateString() : 'N/A'}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
      <div className="mt-3">
        <small className="text-muted">Total workouts: {workouts.length}</small>
      </div>
    </div>
  );
};

export default Workouts;
