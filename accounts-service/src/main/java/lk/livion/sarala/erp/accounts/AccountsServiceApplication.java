package lk.livion.sarala.erp.accounts;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {"lk.livion.sarala.erp.accounts", "lk.livion.sarala.erp.common"})
public class AccountsServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(AccountsServiceApplication.class, args);
    }
}

