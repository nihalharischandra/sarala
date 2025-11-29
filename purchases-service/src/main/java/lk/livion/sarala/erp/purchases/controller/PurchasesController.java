package lk.livion.sarala.erp.purchases.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/purchases")
public class PurchasesController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Purchases Service is running");
    }
}

