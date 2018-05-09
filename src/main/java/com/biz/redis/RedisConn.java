package com.biz.redis;

import redis.clients.jedis.Jedis;

public class RedisConn {
	private static Jedis redis ;
	private RedisConn() {
		
	}
	public static Jedis getRedis() {
		getConn() ;
		return redis;
	}

	public static boolean getConn() {
		redis = RedisPool.getJedis() ;
		return redis.ping().equals("PONG") ;
	}
	
	public static boolean closeConn() {
		redis.close() ;
		return !redis.ping().equals("PONG") ;
	}
}
