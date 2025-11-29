package lk.livion.sarala.erp.accounts.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/accounts")
public class AccountsController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("Accounts Service is running");
    }
}

