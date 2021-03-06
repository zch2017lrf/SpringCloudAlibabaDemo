package com.kaleldo.auth.controller;

import com.kaleldo.auth.service.ValidateCodeService;
import com.kaleldo.exception.KaleldoAuthException;
import com.kaleldo.exception.ValidateCodeException;
import com.kaleldo.pojo.KaleldoResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.provider.token.ConsumerTokenServices;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;

@RestController
public class SecurityController {
    @Autowired
    private ConsumerTokenServices consumerTokenServices;
    @Autowired
    private ValidateCodeService validateCodeService;

    @GetMapping("oauth/test")
    public String testOauth() {
        return "oauth";
    }

    @GetMapping("user")
    public Principal currentUser(Principal principal) {
        return principal;
    }

    @DeleteMapping("signout")
    public KaleldoResponse signout(HttpServletRequest request) throws KaleldoAuthException {
        String authorization = request.getHeader("Authorization");
        String token = StringUtils.replace(authorization, "bearer ", "");
        KaleldoResponse febsResponse = new KaleldoResponse();
        if (!consumerTokenServices.revokeToken(token)) {
            throw new KaleldoAuthException("退出登录失败");
        }
        return febsResponse.message("退出登录成功");
    }
    @GetMapping("captcha")
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws IOException, ValidateCodeException {
        validateCodeService.create(request, response);
    }
}
