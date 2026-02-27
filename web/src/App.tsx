import { useState } from 'react';

import axios from 'axios';

const App = () => {
    const [status, setStatus] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);

    const checkHealth = async () => {
        setLoading(true);
        try {
            const response = await axios.get<{ status: string }>(`${import.meta.env.VITE_BE_URL}/core/health/`);

            setStatus(response.data.status === 'ok' ? 'Healthy' : 'Unhealthy');
        } catch {
            setStatus('Unhealthy - Connection failed');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="flex flex-col items-center justify-center min-h-screen gap-4">
            <button
                onClick={checkHealth}
                disabled={loading}
                className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 disabled:opacity-50"
            >
                {loading ? 'Checking...' : 'Check Backend Health Test'}
            </button>
            {status && (
                <div
                    className={`text-lg font-medium ${status.includes('Healthy') && !status.includes('Unhealthy') ? 'text-green-500' : 'text-red-500'}`}
                >
                    {status}
                </div>
            )}
        </div>
    );
};

export default App;
