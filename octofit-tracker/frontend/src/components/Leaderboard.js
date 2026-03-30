import React, { useState, useEffect } from 'react';
import { fetchData } from '../api/api';

const Leaderboard = () => {
  const [leaderboard, setLeaderboard] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadLeaderboard = async () => {
      try {
        console.log('🥇 Loading Leaderboard component...');
        setLoading(true);
        const data = await fetchData('/api/leaderboards/');
        console.log('🥇 Leaderboard loaded successfully:', data);
        setLeaderboard(data);
      } catch (err) {
        console.error('❌ Failed to load leaderboard:', err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    loadLeaderboard();
  }, []);

  if (loading) return <div className="alert alert-info">Loading leaderboard...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <div className="container mt-4">
      <h2>Leaderboard</h2>
      {leaderboard.length === 0 ? (
        <div className="alert alert-warning">No leaderboard data found</div>
      ) : (
        <div className="table-responsive">
          <table className="table table-striped table-hover">
            <thead className="table-dark">
              <tr>
                <th>Rank</th>
                <th>User</th>
                <th>Points</th>
                <th>Activities</th>
                <th>Score</th>
              </tr>
            </thead>
            <tbody>
              {leaderboard.map((entry, index) => (
                <tr key={entry.id || index}>
                  <td>
                    <strong>#{index + 1}</strong>
                  </td>
                  <td>{entry.user?.username || entry.username || 'N/A'}</td>
                  <td>{entry.points || 0}</td>
                  <td>{entry.activities_count || 0}</td>
                  <td>
                    <span className="badge bg-primary">{entry.score || 0}</span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
      <div className="mt-3">
        <small className="text-muted">Total leaderboard entries: {leaderboard.length}</small>
      </div>
    </div>
  );
};

export default Leaderboard;
