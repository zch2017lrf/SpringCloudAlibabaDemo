package com.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kaleldo.pojo.system.TradeLog;

public interface ITradeLogService extends IService<TradeLog> {
    void orderAndPay(TradeLog tradeLog);
    void pay(TradeLog tradeLog, String transactionId);
}
