package com.jacaranda.model;

import org.apache.commons.codec.digest.DigestUtils;

public class pruebaMD5 {
	
	public static void main(String[] args) {
		
		String cadenaEncriptada = DigestUtils.md5Hex("dario");
		System.out.println(cadenaEncriptada);
	}
}
