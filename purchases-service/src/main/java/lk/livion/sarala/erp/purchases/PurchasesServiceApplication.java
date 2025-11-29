package lk.livion.sarala.erp.purchases;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {"lk.livion.sarala.erp.purchases", "lk.livion.sarala.erp.common"})
public class PurchasesServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(PurchasesServiceApplication.class, args);
    }
}

