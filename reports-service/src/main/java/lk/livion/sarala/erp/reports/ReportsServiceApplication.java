package lk.livion.sarala.erp.reports;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {"lk.livion.sarala.erp.reports", "lk.livion.sarala.erp.common"})
public class ReportsServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ReportsServiceApplication.class, args);
    }
}

