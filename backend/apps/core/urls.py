from apps.core.views.health import HealthCheckView
from apps.core.views.user import CustomRefreshView, CustomTokenPairView
from django.urls import path
from rest_framework.routers import DefaultRouter

router = DefaultRouter()

urlpatterns = [
    # Router URLs
    *router.urls,
    # General
    path("health/", HealthCheckView.as_view(), name="health-check"),
    # Auth
    path("token/refresh/", CustomRefreshView.as_view(), name="token-refresh"),
    path("token/", CustomTokenPairView.as_view(), name="token-obtain"),
]
