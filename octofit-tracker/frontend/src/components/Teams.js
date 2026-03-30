import React, { useState, useEffect } from 'react';
import { fetchData } from '../api/api';

const Teams = () => {
  const [teams, setTeams] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadTeams = async () => {
      try {
        console.log('🏆 Loading Teams component...');
        setLoading(true);
        const data = await fetchData(`https://${process.env.REACT_APP_CODESPACE_NAME}-8000.app.github.dev/api/teams/`);
        console.log('🏆 Teams loaded successfully:', data);
        setTeams(data);
      } catch (err) {
        console.error('❌ Failed to load teams:', err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    loadTeams();
  }, []);

  if (loading) return <div className="alert alert-info">Loading teams...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <div className="container mt-4">
      <h2>Teams</h2>
      {teams.length === 0 ? (
        <div className="alert alert-warning">No teams found</div>
      ) : (
        <div className="table-responsive">
          <table className="table table-striped table-hover">
            <thead className="table-dark">
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Created Date</th>
                <th>Members</th>
              </tr>
            </thead>
            <tbody>
              {teams.map((team) => (
                <tr key={team.id}>
                  <td>{team.id}</td>
                  <td>{team.name || 'N/A'}</td>
                  <td>{team.description || 'N/A'}</td>
                  <td>{team.created_at ? new Date(team.created_at).toLocaleDateString() : 'N/A'}</td>
                  <td>{team.members_count || team.members?.length || 0}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
      <div className="mt-3">
        <small className="text-muted">Total teams: {teams.length}</small>
      </div>
    </div>
  );
};

export default Teams;
