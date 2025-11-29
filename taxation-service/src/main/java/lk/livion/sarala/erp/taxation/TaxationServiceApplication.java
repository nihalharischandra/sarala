package lk.livion.sarala.erp.taxation;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {"lk.livion.sarala.erp.taxation", "lk.livion.sarala.erp.common"})
public class TaxationServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(TaxationServiceApplication.class, args);
    }
}

