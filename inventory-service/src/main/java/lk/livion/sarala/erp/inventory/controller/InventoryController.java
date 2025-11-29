package lk.livion.sarala.erp.inventory.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/inventory")
public class InventoryController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Inventory Service is running");
    }
}

