package lk.livion.sarala.erp.reports.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/reports")
public class ReportsController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Reports Service is running");
    }
}

