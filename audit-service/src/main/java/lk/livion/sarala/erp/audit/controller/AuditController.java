package lk.livion.sarala.erp.audit.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/audit")
public class AuditController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Audit Service is running");
    }
}

