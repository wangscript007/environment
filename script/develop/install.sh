#!/usr/bin/env bash


####################################################################################################


#
# 刷新配置
#
source /etc/profile


####################################################################################################


#
# 高亮
#
echo -e "\033[1m\033[33m开始安装\033[0m"


####################################################################################################


#
# 系统核心
#
SYSTEM_CORES=`cat /proc/cpuinfo| grep "processor"| wc -l`

#
# 系统版本
#
SYSTEM_VERSION=`rpm -q centos-release | cut -d- -f3`

#
# 当前安装包
#
CURRENT_PACKAGE="none"

#
# 脚本目录
#
SHELL_DIRECTORY=$(cd `dirname $0`; pwd)

#
# 安装包目录
#
PACKAGE_DIRECTORY=${SHELL_DIRECTORY}/package

#
# 软件安装目录
#
SOFTWARE_DIRECTORY=${SHELL_DIRECTORY}/software


####################################################################################################


#
# 初始化
#
function Initialize()
{
	#
	# 创建目录
	#
	if [ ! -d "${PACKAGE_DIRECTORY}" ]; then

		mkdir ${PACKAGE_DIRECTORY}

		chmod 755 ${PACKAGE_DIRECTORY}

	fi

	#
	# 创建目录
	#
	if [ ! -d "${SOFTWARE_DIRECTORY}" ]; then

		mkdir ${SOFTWARE_DIRECTORY}

		chmod 755 ${SOFTWARE_DIRECTORY}

	fi

	#
	# 导入路径
	#
	if [ `grep -c "/usr/lib" /etc/ld.so.conf` -eq '0' ]; then

		echo /usr/lib >> /etc/ld.so.conf

		ldconfig

	fi

	#
	# 导入路径
	#
	if [ `grep -c "/usr/lib64" /etc/ld.so.conf` -eq '0' ]; then

		echo /usr/lib64 >> /etc/ld.so.conf

		ldconfig

	fi

	#
	# 导入路径
	#
	if [ `grep -c "/usr/local/lib" /etc/ld.so.conf` -eq '0' ]; then

		echo /usr/local/lib >> /etc/ld.so.conf

		ldconfig

	fi

	#
	# 导入路径
	#
	if [ `grep -c "/usr/local/lib64" /etc/ld.so.conf` -eq '0' ]; then

		echo /usr/local/lib64 >> /etc/ld.so.conf

		ldconfig

	fi
}


####################################################################################################


#
# yum安装检测
#
function InstallCheack()
{
	while [ "1" -eq "1" ]; do

		echo ""
		echo "----------------------------------------"
		echo ""
		echo "yum install -y $@"
		echo ""
		echo "----------------------------------------"
		echo ""

		yum install -y $@

		if [ $? -eq 0 ]; then

			break

		fi

	done
}


#
# yum升级检测
#
function UpgradeCheack()
{
	while [ "1" -eq "1" ]; do

		echo ""
		echo "----------------------------------------"
		echo ""
		echo "yum upgrade -y $@"
		echo ""
		echo "----------------------------------------"
		echo ""

		yum upgrade -y $@

		if [ $? -eq 0 ]; then

			break

		fi

	done
}


#
# yum安装软件
#
function YumInstall()
{
	#
	# epol
	#
	InstallCheack epel-release

	#
	# 更改内容
	#
	sed -i '1,100s/#baseurl/baseurl/g' /etc/yum.repos.d/epel.repo
	sed -i '1,100s/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/epel.repo

	#
	# SCLo
	#
	InstallCheack centos-release-scl

	#
	# yum-utils 包管理工具套件
	# yum-priorities 多yum源下优先级支持
	# yum-fastestmirror 自动选择最快的yum源
	# yum-plugin-downloadonly 下载工具
	#
	InstallCheack yum-utils yum-priorities yum-fastestmirror yum-plugin-downloadonly

	#
	# java
	#
	InstallCheack java-1.8.0-openjdk

	#
	# gcc
	#
	InstallCheack gcc gcc-c++

	#
	# xz
	#
	InstallCheack xz xz-*

	#
	# gdb
	#
	InstallCheack gdb gdb-*

	#
	# git
	#
	InstallCheack git git-*

	#
	# vim
	#
	InstallCheack vim vim-*

	#
	# perl
	#
	InstallCheack perl perl-devel

	#
	# pcre
	#
	InstallCheack pcre pcre-*

	#
	# zlib
	#
	InstallCheack zlib zlib-*

	#
	# llvm
	#
	InstallCheack llvm llvm-*

	#
	# clang
	#
	InstallCheack clang clang-*

	#
	# glibc
	#
	InstallCheack glibc glibc-* glibc.i686 glibc-*.i686

	#
	# mysql
	#
	InstallCheack mysql mysql-*

	#
	# httpd
	#
	InstallCheack httpd httpd-devel

	#
	# gtest
	#
	InstallCheack gtest gtest-devel

	#
	# gmock
	#
	InstallCheack gmock gmock-devel

	#
	# sqlite
	#
	InstallCheack sqlite sqlite-*

	#
	# gcc库
	#
	InstallCheack libgcc libgcc-* libgcc.i686 libgcc-*.i686

	#
	# python
	#
	InstallCheack python python-pip python-devel

	#
	# libtool
	#
	InstallCheack libtool libtool-*

	#
	# libcurl
	#
	InstallCheack libcurl libcurl-*

	#
	# libssh2
	#
	InstallCheack libssh2 libssh2-*

	#
	# libxml2
	#
	InstallCheack libxml2 libxml2-*

	#
	# libpcap
	#
	InstallCheack libpcap libpcap-*

	#
	# openssl
	#
	InstallCheack openssl openssl-*

	#
	# openssh
	#
	InstallCheack openssh openssh-*

	#
	# libevent
	#
	InstallCheack libevent libevent-*

	#
	# binutils
	#
	InstallCheack binutils binutils-devel

	#
	# c++库
	#
	InstallCheack libstdc++ libstdc++-* libstdc++.i686 libstdc++-*.i686

	#
	# gperftools
	#
	InstallCheack gperftools gperftools-*

	#
	# devtoolset
	#
	InstallCheack devtoolset-8 devtoolset-8-*

	#
	# python3.8以上需要
	#
	InstallCheack libffi-devel

	#
	# xz 解压缩工具
	# tar 解压缩工具
	# bzip2 解压缩工具
	#
	InstallCheack xz tar bzip2

	#
	# mtr 路由监测工具
	# htop 进程监测工具
	# dstat 系统监测工具
	# iperf 网络测试工具
	# iftop 流量监测工具
	# iptraf 流量监测工具
	# glances 系统监测工具
	# tcpdump 抓包监测工具
	# sysstat 性能监测工具
	#
	InstallCheack mtr htop dstat iperf iftop iptraf glances tcpdump sysstat

	#
	# rsyslog syslog服务
	# crontabs 定时任务服务
	#
	InstallCheack rsyslog crontabs

	#
	# make 构建工具
	# nasm 汇编工具
	# pkgconfig 用于获得某一个库/模块的所有编译相关的信息
	#
	InstallCheack make nasm pkgconfig

	#
	# jq json解析工具
	# wget 下载工具
	# tree 树形目录查看器
	# tmux 终端复用工具
	# screen 多进程会话
	# doxygen 文档产生工具
	# multitail 多日志监控
	#
	InstallCheack jq wget tree tmux screen doxygen multitail

	#
	# c-ares 安装curl需要
	# texinfo 安装gdb需要
	#
	InstallCheack c-ares texinfo
}


#
# yum 升级软件
#
function YumUpdate()
{
	#
	# nss
	#
	UpgradeCheack nss nss-*

	#
	# git
	#
	UpgradeCheack git git-*

	#
	# curl
	#
	UpgradeCheack curl curl-*
}


#
# yum清理缓存
#
function YumClean()
{
	#
	# 清除yum缓存
	#
	yum clean all
}


#
# yum处理流程
#
function YumProcess()
{
	#
	# yum安装软件
	#
	YumInstall

	#
	# yum升级软件
	#
	YumUpdate

	#
	# yum清理缓存
	#
	YumClean
}


####################################################################################################


#
# 系统处理流程
#
function SystemProcess()
{
	#
	# 设置密码
	#
	echo "root:111111" | chpasswd

	#
	# 开启服务
	#
	service sshd restart
	service httpd restart
	service crond restart
	service mysqld restart
	service rsyslog restart

	#
	# git配置
	#
	git config --global http.postBuffer 1024288000
	git config --list

	#
	# 下载初始化脚本
	#
	wget -P ~ https://raw.githubusercontent.com/offscum/script/master/develop/init.sh

	#
	# 赋予权限
	#
	chmod 777 ~/init.sh
}


####################################################################################################


#
# 安装包检测处理
#
function PackageCheck()
{
	if [ ! -d "${SOFTWARE_DIRECTORY}/go" ]; then

		CURRENT_PACKAGE="${SOFTWARE_DIRECTORY}/go"

		cd ${SOFTWARE_DIRECTORY}

		wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz

		tar -xvf go1.14.2.linux-amd64.tar.gz

		rm -rf go1.14.2.linux-amd64.tar.gz

		mv ${SOFTWARE_DIRECTORY}/go1.14.2.linux-amd64 ${SOFTWARE_DIRECTORY}/go

		if [ ! -d "${SOFTWARE_DIRECTORY}/go" ]; then

			return 1

		fi

		if [ -f "${SOFTWARE_DIRECTORY}/go/bin/go" ]; then

			echo "export GOROOT=${SOFTWARE_DIRECTORY}/go" >> /etc/profile
			echo "export PATH=\$PATH:\$GOROOT/bin" >> /etc/profile

			source /etc/profile

			ln -sf ${SOFTWARE_DIRECTORY}/go/bin/* /usr/local/bin

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/cmake" ]; then

		CURRENT_PACKAGE="${SOFTWARE_DIRECTORY}/cmake"

		cd ${SOFTWARE_DIRECTORY}

		wget https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0-Linux-x86_64.tar.gz

		tar -xvf cmake-3.17.0-Linux-x86_64.tar.gz

		rm -rf cmake-3.17.0-Linux-x86_64.tar.gz

		mv ${SOFTWARE_DIRECTORY}/cmake-3.17.0-Linux-x86_64 ${SOFTWARE_DIRECTORY}/cmake

		if [ ! -d "${SOFTWARE_DIRECTORY}/cmake" ]; then

			return 1

		fi

		if [ -f "${SOFTWARE_DIRECTORY}/cmake/bin/cmake" ]; then

			ln -sf ${SOFTWARE_DIRECTORY}/cmake/bin/* /usr/local/bin

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/python" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/python"

		if [ ! -d "${PACKAGE_DIRECTORY}/python" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tar.xz

			tar -xvf Python-3.8.0.tar.xz

			rm -rf Python-3.8.0.tar.xz

			mv ${PACKAGE_DIRECTORY}/Python-3.8.0 ${PACKAGE_DIRECTORY}/python

		fi

		if [ -d "${PACKAGE_DIRECTORY}/python" ]; then

			cd ${PACKAGE_DIRECTORY}/python

			./configure \
			--prefix=${SOFTWARE_DIRECTORY}/python \
			--enable-shared \
			--enable-profiling \
			--enable-optimizations

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/python" ]; then

			ln -sf ${SOFTWARE_DIRECTORY}/python/bin/python3.8 /usr/local/bin

			echo ${SOFTWARE_DIRECTORY}/python/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/gnu/gmp" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/gmp"

		if [ ! -d "${PACKAGE_DIRECTORY}/gmp" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget http://mirrors.ustc.edu.cn/gnu/gmp/gmp-6.1.2.tar.xz

			tar -xvf gmp-6.1.2.tar.xz

			rm -rf gmp-6.1.2.tar.xz

			mv ${PACKAGE_DIRECTORY}/gmp-6.1.2 ${PACKAGE_DIRECTORY}/gmp

		fi

		if [ -d "${PACKAGE_DIRECTORY}/gmp" ]; then

			cd ${PACKAGE_DIRECTORY}/gmp

			./configure \
			--prefix=${SOFTWARE_DIRECTORY}/gnu/gmp

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/gnu/gmp" ]; then

			echo ${SOFTWARE_DIRECTORY}/gnu/gmp/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	if [ ! -d "${SOFTWARE_DIRECTORY}/gnu/mpfr" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/mpfr"

		if [ ! -d "${PACKAGE_DIRECTORY}/mpfr" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget http://mirrors.ustc.edu.cn/gnu/mpfr/mpfr-4.0.1.tar.gz

			tar -xvf mpfr-4.0.1.tar.gz

			rm -rf mpfr-4.0.1.tar.gz

			mv ${PACKAGE_DIRECTORY}/mpfr-4.0.1 ${PACKAGE_DIRECTORY}/mpfr

		fi

		if [ -d "${PACKAGE_DIRECTORY}/mpfr" ]; then

			cd ${PACKAGE_DIRECTORY}/mpfr

			./configure \
			--prefix=${SOFTWARE_DIRECTORY}/gnu/mpfr \
			--with-gmp=${SOFTWARE_DIRECTORY}/gnu/gmp \
			--enable-thread-safe \
			--enable-warnings

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/gnu/mpfr" ]; then

			echo ${SOFTWARE_DIRECTORY}/gnu/mpfr/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	if [ ! -d "${SOFTWARE_DIRECTORY}/gnu/mpc" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/mpc"

		if [ ! -d "${PACKAGE_DIRECTORY}/mpc" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget http://mirrors.ustc.edu.cn/gnu/mpc/mpc-1.1.0.tar.gz

			tar -xvf mpc-1.1.0.tar.gz

			rm -rf mpc-1.1.0.tar.gz

			mv ${PACKAGE_DIRECTORY}/mpc-1.1.0 ${PACKAGE_DIRECTORY}/mpc

		fi

		if [ -d "${PACKAGE_DIRECTORY}/mpc" ]; then

			cd ${PACKAGE_DIRECTORY}/mpc

			./configure \
			--prefix=${SOFTWARE_DIRECTORY}/gnu/mpc \
			--with-gmp=${SOFTWARE_DIRECTORY}/gnu/gmp \
			--with-mpfr=${SOFTWARE_DIRECTORY}/gnu/mpfr

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/gnu/mpc" ]; then

			echo ${SOFTWARE_DIRECTORY}/gnu/mpc/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	if [ ! -d "${SOFTWARE_DIRECTORY}/gnu/gcc" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/gcc"

		if [ ! -d "${PACKAGE_DIRECTORY}/gcc" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget http://mirrors.ustc.edu.cn/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz

			tar -xvf gcc-9.3.0.tar.gz

			rm -rf gcc-9.3.0.tar.gz

			mv ${PACKAGE_DIRECTORY}/gcc-9.3.0 ${PACKAGE_DIRECTORY}/gcc

		fi

		if [ -d "${PACKAGE_DIRECTORY}/gcc" ]; then

			cd ${PACKAGE_DIRECTORY}/gcc

			CFLAGS=-O2 \
			CXXFLAGS=-O2 \
			CPPFLAGS=-O2 \
			./configure \
			CFLAGS=-O2 \
			CXXFLAGS=-O2 \
			CPPFLAGS=-O2 \
			--prefix=${SOFTWARE_DIRECTORY}/gnu/gcc \
			--mandir=${SOFTWARE_DIRECTORY}/gnu/gcc/share/man \
			--infodir=${SOFTWARE_DIRECTORY}/gnu/gcc/share/info \
			--with-bugurl=http://bugzilla.redhat.com/bugzilla \
			--enable-bootstrap \
			--enable-shared \
			--enable-threads=posix \
			--enable-checking=release \
			--enable-multilib \
			--with-system-zlib \
			--enable-__cxa_atexit \
			--disable-libunwind-exceptions \
			--enable-gnu-unique-object \
			--enable-linker-build-id \
			--with-gcc-major-version-only \
			--with-linker-hash-style=gnu \
			--enable-languages=c,c++ \
			--enable-plugin \
			--enable-libmpx \
			--enable-initfini-array \
			--enable-libgcj \
			--enable-dssi \
			--enable-libgcj-multifile \
			--with-ppl \
			--with-cloog\
			--enable-gnu-indirect-function \
			--with-tune=generic \
			--with-arch_32=i686 \
			--build=x86_64-redhat-linux \
			--with-diagnostics-color=auto \
			--program-suffix=9.3.0 \
			\
			--with-gmp=${SOFTWARE_DIRECTORY}/gnu/gmp \
			--with-mpfr=${SOFTWARE_DIRECTORY}/gnu/mpfr \
			--with-mpc=${SOFTWARE_DIRECTORY}/gnu/mpc \
			\
			CFLAGS=-O2 \
			CXXFLAGS=-O2 \
			CPPFLAGS=-O2

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/gnu/gcc" ]; then

			ln -sf ${SOFTWARE_DIRECTORY}/gnu/gcc/bin/cpp9.3.0 /usr/local/bin
			ln -sf ${SOFTWARE_DIRECTORY}/gnu/gcc/bin/c++9.3.0 /usr/local/bin
			ln -sf ${SOFTWARE_DIRECTORY}/gnu/gcc/bin/g++9.3.0 /usr/local/bin
			ln -sf ${SOFTWARE_DIRECTORY}/gnu/gcc/bin/gcc9.3.0 /usr/local/bin

			\cp ${SOFTWARE_DIRECTORY}/gnu/gcc/lib64/libstdc++.so.6.0.28 /usr/lib64/libstdc++.so.6

			ldconfig

		else

			return 1

		fi

	fi


	if [ ! -d "${SOFTWARE_DIRECTORY}/gnu/gdb" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/gdb"

		if [ ! -d "${PACKAGE_DIRECTORY}/gdb" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget http://mirrors.ustc.edu.cn/gnu/gdb/gdb-8.3.tar.gz

			tar -xvf gdb-8.3.tar.gz

			rm -rf gdb-8.3.tar.gz

			mv ${PACKAGE_DIRECTORY}/gdb-8.3 ${PACKAGE_DIRECTORY}/gdb

		fi

		if [ -d "${PACKAGE_DIRECTORY}/gdb" ]; then

			cd ${PACKAGE_DIRECTORY}/gdb

			rm -rf build && mkdir build && cd build

			../configure \
			--prefix=${SOFTWARE_DIRECTORY}/gnu/gdb \
			--program-suffix=8.3 \
			--enable-libada \
			--enable-libssp \
			--enable-lto \
			--enable-vtable-verify \
			--enable-host-shared \
			\
			--with-gmp=${SOFTWARE_DIRECTORY}/gnu/gmp \
			--with-mpc=${SOFTWARE_DIRECTORY}/gnu/mpc \
			--with-mpfr=${SOFTWARE_DIRECTORY}/gnu/mpfr \
			\
			CC=${SOFTWARE_DIRECTORY}/gnu/gcc/bin/gcc9.3.0 \
			CXX=${SOFTWARE_DIRECTORY}/gnu/gcc/bin/g++9.3.0

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/gnu/gdb" ]; then

			ln -sf ${SOFTWARE_DIRECTORY}/gnu/gdb/bin/* /usr/local/bin

			echo ${SOFTWARE_DIRECTORY}/gnu/gdb/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/openssl" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/openssl"

		if [ ! -d "${PACKAGE_DIRECTORY}/openssl" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget https://www.openssl.org/source/openssl-1.1.1f.tar.gz

			tar -xvf openssl-1.1.1f.tar.gz

			rm -rf openssl-1.1.1f.tar.gz

			mv ${PACKAGE_DIRECTORY}/openssl-1.1.1f ${PACKAGE_DIRECTORY}/openssl

		fi

		if [ -d "${PACKAGE_DIRECTORY}/openssl" ]; then

			cd ${PACKAGE_DIRECTORY}/openssl

			./config \
			--prefix=${SOFTWARE_DIRECTORY}/openssl

			./config -t

			make depend && make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/openssl" ]; then

			echo ${SOFTWARE_DIRECTORY}/openssl/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/curl" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/curl"

		if [ ! -d "${PACKAGE_DIRECTORY}/curl" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget https://curl.haxx.se/download/curl-7.69.0.tar.gz

			tar -xvf curl-7.69.0.tar.gz

			rm -rf curl-7.69.0.tar.gz

			mv ${PACKAGE_DIRECTORY}/curl-7.69.0 ${PACKAGE_DIRECTORY}/curl
		fi

		if [ -d "${PACKAGE_DIRECTORY}/curl" ]; then

			cd ${PACKAGE_DIRECTORY}/curl

			./configure \
			--prefix=${SOFTWARE_DIRECTORY}/curl \
			--with-zlib=/usr \
			--with-ssl=${SOFTWARE_DIRECTORY}/openssl \
			--enable-optimize \
			--enable-warnings \
			--enable-curldebug \
			--enable-http \
			--enable-ftp \
			--enable-file \
			--enable-ldap \
			--enable-ldaps \
			--enable-rtsp \
			--enable-proxy \
			--enable-dict \
			--enable-telnet \
			--enable-tftp \
			--enable-pop3 \
			--enable-imap \
			--enable-smb \
			--enable-smtp \
			--enable-gopher \
			--enable-manual \
			--enable-libcurl-option \
			--enable-libgcc \
			--enable-ipv6 \
			--enable-versioned-symbols \
			--enable-threaded-resolver \
			--enable-pthreads \
			--enable-verbose \
			--enable-sspi \
			--enable-crypto-auth \
			--enable-tls-srp \
			--enable-unix-sockets \
			--enable-cookies \
			--enable-soname-bump \
			\
			CFLAGS=-fPIC \
			CPPFLAGS=-fPIC

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/curl" ]; then

			echo ${SOFTWARE_DIRECTORY}/curl/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/pugixml" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/pugixml"

		if [ ! -d "${PACKAGE_DIRECTORY}/pugixml" ]; then

			cd ${PACKAGE_DIRECTORY}

			git clone --depth 1 https://github.com/zeux/pugixml.git

		fi

		if [ -d "${PACKAGE_DIRECTORY}/pugixml" ]; then

			cd ${PACKAGE_DIRECTORY}/pugixml

			rm -rf build && mkdir build && cd build

			cmake .. \
			-G "Unix Makefiles" \
			-DCMAKE_BUILD_TYPE="Release" \
			-DCMAKE_INSTALL_PREFIX=${SOFTWARE_DIRECTORY}/pugixml \
			-DUSE_POSTFIX=y \
			-DBUILD_SHARED_AND_STATIC_LIBS=y

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/pugixml" ]; then

			echo ${SOFTWARE_DIRECTORY}/pugixml/lib >> /etc/ld.so.conf
			echo ${SOFTWARE_DIRECTORY}/pugixml/lib64 >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/rapidjson" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/rapidjson"

		if [ ! -d "${PACKAGE_DIRECTORY}/rapidjson" ]; then

			cd ${PACKAGE_DIRECTORY}

			git clone --depth 1 https://github.com/Tencent/rapidjson.git

		fi

		if [ -d "${PACKAGE_DIRECTORY}/rapidjson" ]; then

			cd ${PACKAGE_DIRECTORY}/rapidjson

			rm -rf build && mkdir build && cd build

			cmake .. \
			-G "Unix Makefiles" \
			-DCMAKE_BUILD_TYPE="Release" \
			-DCMAKE_INSTALL_PREFIX=${SOFTWARE_DIRECTORY}/rapidjson \
			-DRAPIDJSON_BUILD_EXAMPLES=OFF

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/rapidjson" ]; then

			echo ${SOFTWARE_DIRECTORY}/rapidjson/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/memcached" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/memcached"

		if [ ! -d "${PACKAGE_DIRECTORY}/memcached" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget http://memcached.org/files/memcached-1.6.3.tar.gz

			tar -xvf memcached-1.6.3.tar.gz

			rm -rf memcached-1.6.3.tar.gz

			mv ${PACKAGE_DIRECTORY}/memcached-1.6.3 ${PACKAGE_DIRECTORY}/memcached

		fi

		if [ -d "${PACKAGE_DIRECTORY}/memcached" ]; then

			cd ${PACKAGE_DIRECTORY}/memcached

			./configure \
			--prefix=${SOFTWARE_DIRECTORY}/memcached \
			--with-libevent=/usr \
			\
			CFLAGS=-fPIC \
			CPPFLAGS=-fPIC \
			CXXFLAGS=-fPIC

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/memcached" ]; then

			ln -sf ${SOFTWARE_DIRECTORY}/memcached/bin/memcached /usr/local/bin/

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${SOFTWARE_DIRECTORY}/libmemcached" ]; then

		CURRENT_PACKAGE="${PACKAGE_DIRECTORY}/libmemcached"

		if [ ! -d "${PACKAGE_DIRECTORY}/libmemcached" ]; then

			cd ${PACKAGE_DIRECTORY}

			wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz

			tar -xvf libmemcached-1.0.18.tar.gz

			rm -rf libmemcached-1.0.18.tar.gz

			mv ${PACKAGE_DIRECTORY}/libmemcached-1.0.18 ${PACKAGE_DIRECTORY}/libmemcached

		fi

		if [ -d "${PACKAGE_DIRECTORY}/libmemcached" ]; then

			cd ${PACKAGE_DIRECTORY}/libmemcached

			./configure \
			--prefix=${SOFTWARE_DIRECTORY}/libmemcached \
			--with-memcached=${SOFTWARE_DIRECTORY}/memcached \
			\
			--enable-static=yes \
			--enable-shared=yes \
			--enable-libmemcachedprotocol \
			\
			CFLAGS=-fPIC \
			CPPFLAGS=-fPIC \
			CXXFLAGS=-fPIC

			make -j${SYSTEM_CORES} && make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${SOFTWARE_DIRECTORY}/libmemcached" ]; then

			echo ${SOFTWARE_DIRECTORY}/libmemcached/lib >> /etc/ld.so.conf

			ldconfig

		else

			return 1

		fi

	fi


	####################################################################################################


	#
	# 返回成功
	#
	return 0
}


#
# 安装包安装软件
#
function PackageInstall()
{
	#
	# 安装包检测处理
	#
	PackageCheck

	#
	# 循环处理
	#
	while [[ $? -eq 1 ]]; do

		#
		# 错误信息
		#
		echo ""
		echo "********** Package "${CURRENT_PACKAGE}" Error **********"
		echo ""

		#
		# 删除安装包
		#
		rm -rf ${CURRENT_PACKAGE}

		#
		# 睡眠
		#
		sleep 10s

		#
		# 安装包检测处理
		#
		PackageCheck

	done
}


#
# 安装包清理缓存
#
function PackageClean()
{
	#
	# 删除源码
	#
	if [ -d "${PACKAGE_DIRECTORY}" ]; then

		rm -rf ${PACKAGE_DIRECTORY}

	fi
}


#
# 安装包处理流程
#
function PackageProcess()
{
	#
	# 安装包安装软件
	#
	PackageInstall

	#
	# 安装包清理缓存
	#
	PackageClean
}


####################################################################################################


#
# 初始化
#
Initialize

#
# yum处理流程
#
YumProcess

#
# 系统处理流程
#
SystemProcess

#
# 安装包处理流程
#
PackageProcess


####################################################################################################


#
# 高亮
#
echo -e "\033[1m\033[33m结束安装\033[0m"


####################################################################################################