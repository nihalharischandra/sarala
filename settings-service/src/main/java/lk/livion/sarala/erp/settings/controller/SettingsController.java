package lk.livion.sarala.erp.settings.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/settings")
public class SettingsController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Settings Service is running");
    }
}

