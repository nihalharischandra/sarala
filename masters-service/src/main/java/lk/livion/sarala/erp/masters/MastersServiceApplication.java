package lk.livion.sarala.erp.masters;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {"lk.livion.sarala.erp.masters", "lk.livion.sarala.erp.common"})
public class MastersServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(MastersServiceApplication.class, args);
    }
}

