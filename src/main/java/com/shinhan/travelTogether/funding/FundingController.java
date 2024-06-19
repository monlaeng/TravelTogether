package com.shinhan.travelTogether.funding;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.shinhan.travelTogether.member.MemberDTO;

@Controller
@RequestMapping("/funding")
public class FundingController {
	
	@Autowired
	FundingService fService;
	
	@GetMapping("/fundingList.do") 
	public void selectAll(Model model, HttpServletRequest request) {

	}

	@GetMapping("/fundingListItem.do") 
	public void selectItem(Model model, HttpServletRequest request, String selectOption) {
		System.out.println(selectOption);
		
		
		model.addAttribute("fundlist", fService.selectAll(selectOption));
		model.addAttribute("tlist", fService.selectFudingTheme());
	}


	@GetMapping("/fundingInput.do")
	public void inputPage(){
		
	}
	
	@PostMapping("/fundingInput.do") 
	public String inputFunding(HttpServletRequest request ,FundingDTO fund) {
		
		//세션이 없으면 로그인 페이지로
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return "redirect:../auth/login.do";
		}
		System.out.println("Funding Input 확인 1 : " + fund);
		if(fund.traffic==null && fund.accommodation == null)
			fund.setConfirm_option(0);
		else if(fund.traffic != null && fund.accommodation != null) {
			fund.setConfirm_option(3);
		} else if(fund.accommodation !=null) {
			fund.setConfirm_option(1);
		} else {
			fund.setConfirm_option(2);
		}
		fund.setFunding_state(0);
		fund.setViews(0);
		fund.setMember_id(member.getMember_id());
		System.out.println("Funding Input 확인 2 : " + fund);
		int result = fService.insertFunding(fund);
		System.out.println(result + "건 입력");
		return "redirect:fundingList.do";
	}


}
