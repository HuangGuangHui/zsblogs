package com.zs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zs.dao.ReadMapper;
import com.zs.dao.UsersMapper;
import com.zs.entity.Read;
import com.zs.entity.Users;
import com.zs.entity.other.EasyUIAccept;
import com.zs.entity.other.EasyUIPage;
import com.zs.service.ReadSer;

@Service("readSer")
public class ReadSerImpl implements ReadSer{
	
	@Resource
	private ReadMapper readMapper;
	@Resource
	private UsersMapper usersMapper;
	
	
	
	public EasyUIPage queryFenye(EasyUIAccept accept) {
		if (accept!=null) {
			Integer page=accept.getPage();
			Integer size=accept.getRows();
			if (page!=null && size!=null) {
				accept.setStart((page-1)*size);
				accept.setEnd(page*size);
			}
			List list=readMapper.queryFenye(accept);
			int rows=readMapper.getCount(accept);
			//带上用户的信息
			for (Object obj : list) {
				Read r=(Read)obj;
				if(r.getuId()!=null){
					Users u=usersMapper.selectByPrimaryKey(r.getuId());
					r.setUser(u);
				}
			}
			return new EasyUIPage(rows, list);
		}
		return null;
	}

	public String add(Read obj) {
		return String.valueOf(readMapper.insertSelective(obj));
	}

	public String update(Read obj) {
		return String.valueOf(readMapper.updateByPrimaryKeySelective(obj));
	}

	public String delete(Integer id) {
		return String.valueOf(readMapper.deleteByPrimaryKey(id));
	}

	public Read get(Integer id) {
		return readMapper.selectByPrimaryKey(id);
	}

}
