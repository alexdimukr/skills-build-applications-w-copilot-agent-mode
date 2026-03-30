import React, { useState, useEffect } from 'react';
import { fetchData } from '../api/api';

const Activities = () => {
  const [activities, setActivities] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadActivities = async () => {
      try {
        console.log('🏃 Loading Activities component...');
        setLoading(true);
        const data = await fetchData(`https://${process.env.REACT_APP_CODESPACE_NAME}-8000.app.github.dev/api/activities/`);
        console.log('🏃 Activities loaded successfully:', data);
        setActivities(data);
      } catch (err) {
        console.error('❌ Failed to load activities:', err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    loadActivities();
  }, []);

  if (loading) return <div className="alert alert-info">Loading activities...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <div className="container mt-4">
      <h2>Activities</h2>
      {activities.length === 0 ? (
        <div className="alert alert-warning">No activities found</div>
      ) : (
        <div className="table-responsive">
          <table className="table table-striped table-hover">
            <thead className="table-dark">
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Type</th>
                <th>Duration</th>
                <th>Calories</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              {activities.map((activity) => (
                <tr key={activity.id}>
                  <td>{activity.id}</td>
                  <td>{activity.name || 'N/A'}</td>
                  <td>{activity.type || 'N/A'}</td>
                  <td>{activity.duration || 'N/A'} min</td>
                  <td>{activity.calories || 'N/A'}</td>
                  <td>{activity.date ? new Date(activity.date).toLocaleDateString() : 'N/A'}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
      <div className="mt-3">
        <small className="text-muted">Total activities: {activities.length}</small>
      </div>
    </div>
  );
};

export default Activities;
