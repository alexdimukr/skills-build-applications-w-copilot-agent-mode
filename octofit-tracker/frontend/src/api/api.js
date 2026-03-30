/**
 * API utility functions for connecting to the OctoFit Tracker backend
 */

// Get the base URL for API calls
const getBaseURL = () => {
  const codespaceName = process.env.REACT_APP_CODESPACE_NAME;
  
  if (codespaceName) {
    return `https://${codespaceName}-8000.app.github.dev`;
  }
  
  return 'http://localhost:8000';
};

/**
 * Fetch data from a given endpoint
 * Handles both paginated (.results) and plain array responses
 * @param {string} endpoint - API endpoint (e.g., '/api/users/', '/api/activities/')
 * @returns {Promise<Array>} - Array of data items
 */
export const fetchData = async (endpoint) => {
  const baseURL = getBaseURL();
  const url = `${baseURL}${endpoint}`;
  
  console.log(`🔗 Fetching data from: ${url}`);
  
  try {
    const response = await fetch(url);
    
    if (!response.ok) {
      throw new Error(`API Error: ${response.status} ${response.statusText}`);
    }
    
    const data = await response.json();
    
    console.log(`✅ Data fetched from ${endpoint}:`, data);
    
    // Handle paginated response (DRF default pagination includes 'results')
    if (data.results && Array.isArray(data.results)) {
      console.log(`📄 Paginated response - returning ${data.results.length} items`);
      return data.results;
    }
    
    // Handle plain array response
    if (Array.isArray(data)) {
      console.log(`📋 Plain array response - returning ${data.length} items`);
      return data;
    }
    
    // Handle single object response
    console.warn(`⚠️  Unexpected response format:`, data);
    return [];
  } catch (error) {
    console.error(`❌ Error fetching from ${endpoint}:`, error);
    throw error;
  }
};

/**
 * Get the base URL (useful for debugging)
 * @returns {string} - Base URL for API
 */
export const getAPIBaseURL = () => {
  return getBaseURL();
};
