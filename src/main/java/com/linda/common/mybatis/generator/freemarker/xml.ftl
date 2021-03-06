<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<!--  AutoGenerated by lindzh  ${mybatis.time} -->
<mapper namespace="${mybatis.daoPackage}.${mybatis.daoClassName}">

	<resultMap id="${mybatis.beanMapper}" type="${mybatis.className}">
		<id property="${mybatis.primary.property}" column="${mybatis.primary.column}"/>
		<#list mybatis.columns as co>
		<result property="${co.property}" column="${co.column}"/>
		</#list>
	</resultMap>
	
	<insert id="add${mybatis.classSimpleName}" <#if mybatis.autoGenerate>useGeneratedKeys="true" keyProperty="${mybatis.primary.property}"</#if> parameterType="${mybatis.className}">
		insert into ${mybatis.table}(
		<#assign idx=0>
		<#list mybatis.columns as c>
			${c.column}
			<#assign idx=idx+1>
			<#if (idx<mybatis.columns?size)>,</#if>
		</#list>
		<#if !mybatis.autoGenerate>
			,${mybatis.primary.column}
		</#if>
	) values(
		<#assign idx=0>
		<#list mybatis.columns as c>
			${pre}${c.property}${end}
			<#assign idx=idx+1>
			<#if (idx<mybatis.columns?size)>,</#if>
		</#list>
		<#if !mybatis.autoGenerate>
			,${pre}${mybatis.primary.property}${end}
		</#if>
	)
	</insert>
	
<#list mybatis.uniques as u>
	<#--UNIQUE SELECT-->
	<#if u.select>
	<select id="getBy${u.name}" resultMap="${mybatis.beanMapper}">
	select * from ${mybatis.table} where
	<#assign idx=0>
	<#list u.columns as c>
		${c.column}=${pre}${c.property}${end}
		<#assign idx=idx+1>
		<#if (idx<u.columns?size)> and </#if>
	</#list>
	</select>
	</#if>
	
	<#--UNIQUE UPDATE-->
	<#if (u.update&&u.updateColumns?size>0)>
	<#assign has=false>
	<update id="updateBy${u.name}" parameterType="${mybatis.className}">
	update ${mybatis.table} set
	<#list u.updateColumns as c>
		<#if has>,</#if>
		${c.column}=${pre}obj.${c.property}${end}
		<#assign has=true>
	</#list>
	where
	<#assign idx=0>
	<#list u.columns as c>
		${c.column}=${pre}obj.${c.property}${end}
		<#assign idx=idx+1>
		<#if (idx<u.columns?size)> and </#if>
	</#list>
	</update>
	</#if>
	
	<#--UNIQUE DELETE-->
	<#if u.delete>
	<delete id="deleteBy${u.name}">
		delete from ${mybatis.table} where 
		<#assign idx=0>
		<#list u.columns as c>
			${c.column}=${pre}${c.property}${end}
			<#assign idx=idx+1>
			<#if (idx<u.columns?size)> and </#if>
		</#list>
	</delete>
	</#if>
</#list>

<#list mybatis.indexes as index>
	<#if index.limitOffset>
	<select id="getListBy${index.name}" resultMap="${mybatis.beanMapper}">
	select * from ${mybatis.table} where
		<#assign idx=0>
		<#list index.columns as c>
			${c.column}=${pre}${c.property}${end}
			<#assign idx=idx+1>
			<#if (idx<index.columns?size)> and </#if>
		</#list>
		order by id desc limit ${pre}limit${end} offset ${pre}offset${end}
	</select>
	</#if>

	
	<#if index.count>
	<select id="getCountBy${index.name}" resultType="long">
	select count(*) from ${mybatis.table} where
		<#assign idx=0>
		<#list index.columns as c>
			${c.column}=${pre}${c.property}${end}
			<#assign idx=idx+1>
			<#if (idx<index.columns?size)> and </#if>
		</#list>
	</select>
	</#if>
	
	<#if index.selectOne>
	<select id="getOneBy${index.name}" resultMap="${mybatis.beanMapper}">
	select * from ${mybatis.table} where
		<#assign idx=0>
		<#list index.columns as c>
			${c.column}=${pre}${c.property}${end}
			<#assign idx=idx+1>
			<#if (idx<index.columns?size)> and </#if>
		</#list>
		order by id desc limit 1
	</select>
	</#if>
</#list>
</mapper>