package lk.livion.sarala.erp.hr.controller;

import lk.livion.sarala.erp.common.dto.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/hr")
public class HrPayrollController {

    @GetMapping("/health")
    public ApiResponse<String> health() {
        return ApiResponse.success("HR Payroll Service is running");
    }
}

