package lk.livion.sarala.erp.taxation.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/taxation")
public class TaxationController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Taxation Service is running");
    }
}

