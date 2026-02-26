from apps.core.serializers.health import HealthCheckSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView


class HealthCheckView(APIView):
    """
    Verify backend service is running
    """

    serializer_class = HealthCheckSerializer

    def get(self, request, *args, **kwargs):
        """Returns 200 if healthy"""

        return Response({"status": "ok"}, status=status.HTTP_200_OK)
