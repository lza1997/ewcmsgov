/*
 * Copyright (c)2010 Jiangxi Institute of Computing Technology(JICT), All rights reserved.
 * JICT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.jict.org
 */
package com.ewcms.content.document.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;

import com.ewcms.plugin.onlineoffice.model.Matter;

/**
 * 公民
 * 
 * <ul>
 * <li>id:编号</li>
 * <li>name:名称</li>
 * </ul>
 * 
 * @author 吴智俊
 */
@Entity
@Table(name = "doc_citizen")
@SequenceGenerator(name = "seq_doc_citizen", sequenceName = "seq_doc_citizen_id", allocationSize = 1)
public class Citizen implements Serializable {

	private static final long serialVersionUID = -908885747631291293L;

	@Id
	@GeneratedValue(generator = "seq_doc_citizen", strategy = GenerationType.SEQUENCE)
	private Integer id;
	@Column(name = "citizen_name", nullable = false)
	private String name;
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY, mappedBy="citizens")
	@OrderBy(value = "id")
	private List<Matter> matters;
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY, mappedBy = "citizens")
	@OrderBy(value = "id")
	private List<ArticleMain> articleRmcs;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@JsonIgnore
	public List<Matter> getMatters() {
		return matters;
	}

	public void setMatters(List<Matter> matters) {
		this.matters = matters;
	}

	@JsonIgnore
	public List<ArticleMain> getArticleRmcs() {
		return articleRmcs;
	}

	public void setArticleRmcs(List<ArticleMain> articleRmcs) {
		this.articleRmcs = articleRmcs;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Citizen other = (Citizen) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
