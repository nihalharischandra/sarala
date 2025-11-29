package lk.livion.sarala.erp.sales.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/sales")
public class SalesController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Sales Service is running");
    }
}

