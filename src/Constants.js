
export const DZG_API_HOST = "localhost"; // "deezer-graph-api-38e2480498ba.herokuapp.com";
export const DZG_API_PORT = 8502; // NaN;
export const DZG_API_BASE_URL = (isNaN(DZG_API_PORT)) ? `https://${DZG_API_HOST}` : `http://${DZG_API_HOST}:${DZG_API_PORT}`;
export const VERSION = '1.0';
export const SESSION_ID_KEY = "session_id";