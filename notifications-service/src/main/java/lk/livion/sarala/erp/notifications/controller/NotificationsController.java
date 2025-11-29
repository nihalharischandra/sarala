package lk.livion.sarala.erp.notifications.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/notifications")
public class NotificationsController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Notifications Service is running");
    }
}

