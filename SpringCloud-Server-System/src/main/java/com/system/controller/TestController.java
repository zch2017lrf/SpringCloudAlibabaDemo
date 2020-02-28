package com.system.controller;

import com.kaleldo.pojo.system.TradeLog;
import com.system.service.ITradeLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Autowired
    private ITradeLogService tradeLogService;

    @GetMapping("hello")
    public String hello(String name) {
        return "hello" + name;
    }

    @GetMapping("pay")
    public void orderAndPay(TradeLog tradeLog) {
        this.tradeLogService.orderAndPay(tradeLog);
    }

}
