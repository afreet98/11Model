package com.model2.mvc.service.product;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;


public interface ProductDao {
	

	public void addProduct(Product product) throws Exception ;

	// SELECT ONE
	public Product getProduct(int ProdNo) throws Exception ;

	// SELECT LIST
	public List<Product> getProductList(Search search) throws Exception ;

	// UPDATE
	public void updateProduct(Product product) throws Exception ;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
}