package lk.livion.sarala.erp.sales;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {"lk.livion.sarala.erp.sales", "lk.livion.sarala.erp.common"})
public class SalesServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(SalesServiceApplication.class, args);
    }
}

