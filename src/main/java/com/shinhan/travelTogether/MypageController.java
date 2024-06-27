package com.shinhan.travelTogether;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.travelTogether.coupon.CouponService;
import com.shinhan.travelTogether.coupon.UserCouponDTO;
import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.member.MemberService;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	@Autowired
	CouponService userCouponService;
	
	@Autowired
	MemberService mService;

	@GetMapping("/correction.do")
	public void correction(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
	}
	
	@GetMapping("/correctionForm.do")
	public void correctionForm(@RequestParam("login_id") String login_id, 
	                           @RequestParam("login_pwd") String login_pwd, 
	                           HttpServletRequest request, 
	                           HttpServletResponse response,
	                           HttpSession session) throws IOException, ServletException {
		System.out.println("testestsetstsetetse");
	    MemberDTO member = (MemberDTO) session.getAttribute("member");
	    String message = "0";
	    System.out.println(login_id);
	    System.out.println(login_pwd);
	    System.out.println(member.getLogin_id());
	    System.out.println(member.getLogin_pwd());
	    if (login_id.equals(member.getLogin_id()) && login_pwd.equals(member.getLogin_pwd())) { 
	        message = "1";
	    }
	   response.getWriter().append(message);
	}
	
	@PostMapping("/correction.do")
	public String join(MemberDTO member, RedirectAttributes redirectAttr, HttpSession session) throws ParseException {
		System.out.println(member);
		int result = mService.updateMember(member);
		String message;
		if (result > 0) {
			message = "update success";
			session.setAttribute("member", mService.loginChk(member.getLogin_id(), member.getLogin_pwd()));
		} else {
			message = "update fail";
		}

		return "redirect:correction.do";
	}

	@GetMapping("/couponList.do")
	public void userCouponList(Model model) {

		// �α��� ��� ������ ����
		int userId = 1;
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println(couponlist.toString());
		logger.info(couponlist.size() + "�� ��ȸ��");
		model.addAttribute("couponlist", couponlist);
	}
}