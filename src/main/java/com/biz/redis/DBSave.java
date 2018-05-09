package com.biz.redis;

import java.util.List;

import com.biz.model.Student;

public class DBSave {
	public static List<Student> list ;

	public static List<Student> getList() {
		return list;
	}

	public static void setList(List<Student> list) {
		DBSave.list = list;
	}
}
