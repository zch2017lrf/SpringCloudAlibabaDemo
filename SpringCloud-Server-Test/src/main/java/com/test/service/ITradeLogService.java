package com.test.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kaleldo.pojo.system.TradeLog;

public interface ITradeLogService  extends IService<TradeLog> {
    void packageAndSend(TradeLog tradeLog);
}
