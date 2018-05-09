package com.biz.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import com.biz.model.Student;
import com.biz.redis.DBSave;
import com.biz.redis.RedisConn;

import redis.clients.jedis.Jedis;

public class StudentDao {
	public int IdExist(String id) {
		Jedis jedis = RedisConn.getRedis() ;
		if("".equals(id) || jedis.exists(id)) {
			jedis.close() ;
			return 1 ;
		}else {
			jedis.close() ;
			return 0 ;
		}
	}
	
	public void Create(Student student) throws Exception {
		// TODO Auto-generated method stub
		Jedis jedis = RedisConn.getRedis() ;
		jedis.rpush(student.getId(), student.getName(), student.getBirthday() ,
				 student.getAvgscore(), student.getDescription()) ;
		jedis.close() ;
		SelectAll() ;
	}

	public void Update(Student student) throws Exception {
		// TODO Auto-generated method stub
		Delete(student) ;
		Create(student) ;
		SelectAll() ; 
		
	}

	public void Delete(Student student) throws Exception {
		// TODO Auto-generated method stub
		Jedis jedis = RedisConn.getRedis() ;
		jedis.del(student.getId()) ;	
		jedis.close() ;
		SelectAll() ;
	}

	public void SelectAll() throws Exception {
		// TODO Auto-generated method stub
		Jedis jedis = RedisConn.getRedis() ;
		Iterator<String> iterator = jedis.keys("*").iterator() ;
		List<Student> list = new ArrayList<Student>() ;
		Student student ;
		while(iterator.hasNext()) {
			student = new Student() ;
			String id = iterator.next() ;
			List<String> data = jedis.lrange(id, 0, -1) ;
			student.setId(id) ;
			student.setName(data.get(0)) ;
			student.setBirthday(data.get(1)) ;
			student.setAvgscore(data.get(2)) ;
			student.setDescription(data.get(3)) ;
			list.add(student) ;
		}
		Collections.sort(list, new Comparator<Student>() {

			public int compare(Student s1, Student s2) {
				// TODO Auto-generated method stub
				if (Integer.valueOf(s1.getAvgscore()) > Integer.valueOf(s2.getAvgscore())) {
					return 1 ;
				} else if (Integer.valueOf(s1.getAvgscore()) == Integer.valueOf(s2.getAvgscore())) {
					return 0 ;
				} else {
					return -1 ;
				}
			}			
		});
		DBSave.setList(list) ;
		jedis.close() ;
	}
}
