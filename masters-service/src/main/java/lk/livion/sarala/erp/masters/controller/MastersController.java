package lk.livion.sarala.erp.masters.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/masters")
public class MastersController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Masters Service is running");
    }
}

