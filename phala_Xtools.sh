#!/bin/bash

#color
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'

#prefix
info="${green}[信息]${none}"
error="${red}[错误]${none}"

#show
show_error(){
  echo -e "${Error}" "$1"
}

###变量定义###
github_cn="github.phala.one"
sgx_cn="sgx.phala.one"
node_cn="node.phala.one"

sh_url="https://sh.phala.one/phala_Xtools.sh"
script_url="https://$github_cn/Phala-Network/solo-mining-scripts/archive/para.zip"
docker_cn="curl -sSL https://get.daocloud.io/docker | sh"


###1.下载Phala脚本
download_phala(){
cd ${HOME}/ && sudo apt-get -y install wget && apt-get -y install unzip && wget -O para.zip ${script_url} && unzip para.zip && cd ${HOME}/solo-mining-scripts-para/ && sudo chmod +x install.sh && sudo ./install.sh cn
}

###2.检测系统环境
check_env(){
board=`sudo dmidecode | grep 'Product Name'`
cpu=`sudo dmidecode  | grep CPU`
echo $board
echo $cpu

kenel1=`uname -r`
kenel2="5.11.0"
kenelresult=$(echo "$kenel1" | grep "$kenel2")

check_sgx

if [[ "kenelresult" != "" ]]
    then
    echo "---您的内核版本大于5.10，内核版本过高，请降低内核版本！---"
fi


}

###检查SGX是否启动
check_sgx() {
#  echo "使用sgx_enable激活SGX功能"
  cd ${HOME}/solo-mining-scripts-para
  sudo chmod +x sgx_enable
  res=`sudo ./sgx_enable`
  res2="is already enabled"
  res3="is rebooted"
  result=$(echo "$res" | grep "$res2")
  result2=$(echo "$res" | grep "$res3")
  if [[ "$result" != "" ]]
  then
    echo "---SGX已经开启---"
    echo "开始安装Phala工具"
    sudo chmod +x install.sh
    sudo ./install.sh cn
    echo "安装Phala脚本"
    sudo phala install
	if [[ "$result2" != "" ]]
		then
		echo "请重启服务器：sudo reboot"
	fi
  else 
	echo "---请检查BOIS是否开启SGX---"
  fi
}

###3.安装Phala程序
install_phala(){
sudo phala install
}

###4.启动Phala程序
start_phala(){
sudo phala start
}

###5.停止Phala容器
stop_phala(){
sudo phala stop
}

###6.查看状态&矿机公钥
check_status(){
sudo phala status
}

###7.查看Phala logs日志
check_logs(){
sudo phala logs
}

###8.查看抵押池和Gas配置
show_config(){
sudo phala config show
}

###9.修改抵押池和Gas配置
set_config(){
sudo phala config set
}

###10.更新Phala script脚本
update_script(){
sudo phala update script
}

###11.更新Phala镜像(不清空数据)
update_phala(){
sudo phala update
}

###12.更新Phala镜像(清空数据！)
update_clean_phala(){
sudo phala update clean
}

###13.自定义Khala-node数据位置
set_khala_node(){

	local knode_dir
	while true ; do
		read -p "请输入Khala-node数据存储位置: " knode_dir
		if [[ $knode_dir =~ \ |\' ]]; then
			printf "数据存储位置不能包含空格，请重新输入!\n"
		else
		    sed -i "22c docker run -dti --rm --name khala-node -e NODE_NAME=\$node_name -e NODE_ROLE=MINER -p 40333:30333 -p 40334:30334 -v $knode_dir:/root/data phalanetwork/khala-node" /opt/phala/scripts/start.sh
			break
		fi
	done
}

###14.导入Khala-node镜像
import_khala_images(){
echo "编写中"
}

###15.导出Khala-node镜像
export_khala_images(){
echo "编写中"
}

###18.一键修改脚本为CN
set_cn(){
installdir=/opt/phala
scriptdir=$installdir/scripts
source $scriptdir/utils.sh
source $scriptdir/config.sh
source $scriptdir/install_phala.sh
source $scriptdir/logs.sh
source $scriptdir/start.sh
source $scriptdir/status.sh
source $scriptdir/stop.sh
source $scriptdir/uninstall.sh
source $scriptdir/update.sh
###替换github_cn
echo -e "\033[31m正在替换github镜像源\033[0m"
sed -i "s/github.com/$github_cn/g" $scriptdir/install_phala.sh
sed -i "s/github.com/$github_cn/g" $scriptdir/update.sh
###替换sgx_cn
echo -e "\033[32m正在替换sgx驱动镜像源\033[0m"
sed -i "s/download.01.org/$sgx_cn/g" $installdir/.env
###替换node_cn
echo -e "\033[33m正在替换Nodejs镜像源\033[0m"
sed -i "s/deb.nodesource.com/$node_cn/g" $scriptdir/install_phala.sh

###替换docker_cn
echo -e "\033[34m正在替换docker镜像源\033[0m"
sed -i "21,24d" $scriptdir/install_phala.sh
sed -i "/docker)/a$docker_cn" $scriptdir/install_phala.sh
#   sed -i "s/download.docker.com/$docker_cn/g" $scriptdir/install_phala.sh
echo -e "\033[41;33m已经替换完成，愉快地安装吧\033[0m"
}


###19.设置内核版本
set_kenel(){
echo -e "\033[31m编写中\033[0m"
}

###88.卸载Phala程序
uninstall_phala(){
sudo phala uninstall
}

###66.更新phala_Xtools脚本
update_sh(){
cd ${HOME}/ && sudo wget -O phala_Xtools.sh ${sh_url} && chmod +x phala_Xtools.sh && sudo ./phala_Xtools.sh
}

all(){
while true 
        do
cat << EOF
-----------------------------------------------------
    --------------------------------------------
		 Phala_Xtools 全节点挖矿
		 Author @苏格 QQ6559178
    --------------------------------------------
脚本来源：https://phala.one    
官方Wiki：https://wiki.phala.network/zh-cn/docs/
==快捷引导官方脚本操作 镜像无修改可放心使用==
(1) 下载Phala脚本(必备)
(2) 系统环境检测(必要)
(3) 安装Phala程序(必需)
(4) 启动Phala容器
(5) 停止Phala容器
(6) 查看状态&矿机公钥
(7) 查看Phala logs日志
(8) 查看抵押池和Gas配置
(9) 修改抵押池和Gas配置
(10) 更新Phala script脚本
(11) 更新Phala镜像(不清空数据)
(12) 更新Phala镜像(清空数据！)
(13) 自定义Khala-node数据位置
~~~~~~~~~~~~~~↓核武器系列(不懂勿用)↓~~~~~~~~~~~~~~
(18) 国内一键加速脚本
(19) 一键修复内核版本
~~~~~~~~~~~~~~↑核武器系列(不懂勿用)↑~~~~~~~~~~~~~~
(66) 更新phala_Xtools
(88) 卸载Phala程序
(0) 退出脚本

==执行完1后可执行18加速 卡住可ctrl+c后再执行==
-----------------------------------------------------
EOF
                read -p "请输入要执行的选项: " input
                case $input in
                        1)
                                echo "---正在下载最新Phala脚本---"
                                download_phala
                                ;;
                        2)
                                echo "---正在检测您的系统环境---"
                                check_env
                                ;;
                        3)
                                echo "---正在安装Phala程序---"
                                install_phala
                                ;;
                        4)
                                echo "---正在启动Phala容器---"
                                start_phala
                                ;;
                        5)
                                echo "---正在停止Phala容器---"
                                stop_phala
                                ;;								
                        6)
                                echo "---正在查看状态&矿机公钥---"
                                check_status
                                ;;	
                        7)
                                echo "---正在查看Phala logs日志---"
                                check_logs
                                ;;
                        8)
                                echo "---正在查看抵押池和Gas配置---"
                                show_config
                                ;;
                        9)
                                echo "---正在修改抵押池和Gas配置---"
                                set_config
                                ;;
                        10)
                                echo "---正在更新Phala script脚本---"
                                update_script
                                ;;
                        11)
                                echo "---正在更新Phala镜像 不清空数据---"
                                update_phala
                                ;;
                        12)
                                echo "---正在更新Phala镜像 清空之前数据---"
                                update_clean_phala
                                ;;
                        13)
                                echo "---正在自定义Khala-node数据位置---"
                                set_khala_node
                                ;;								
                        14)
                                echo "---正在导入Khala-node镜像---"
                                import_khala_images
                                ;;
                        15)
                                echo "---正在导出Khala-node镜像---"
                                export_khala_images
                                ;;
                        18)
                                echo "---正在一键修改脚本为CN---"
                                set_cn
                                ;;	
                        19)
                                echo "---正在一键更新内核为5.8---"
                                set_kenel
                                ;;
                        66)
                                echo "---正在更新phala_Xtools---"
                                update_sh
                                ;;
                        88)
                                echo "---正在卸载phala程序---"
                                uninstall_phala
                                ;;
                        *)
                                exit 1
                                ;;
                esac

done
}
while true 
        do
cat << EOF
-----------------------------------------------------
    --------------------------------------------
		 Phala_Xtools 全节点挖矿
		 Author @苏格 QQ6559178
    --------------------------------------------
脚本来源：https://phala.one    
官方Wiki：https://wiki.phala.network/zh-cn/docs/
==快捷引导官方脚本操作 镜像无修改可放心使用==
(1) 下载Phala脚本(必备)
(2) 系统环境检测(必要)
(3) 安装Phala程序(必需)
(4) 启动Phala容器
(5) 停止Phala容器
(6) 查看状态&矿机公钥
(7) 查看Phala logs日志
(8) 查看抵押池和Gas配置
(9) 修改抵押池和Gas配置
(10) 更新Phala script脚本
(11) 更新Phala镜像(不清空数据)
(12) 更新Phala镜像(清空数据！)
(13) 自定义Khala-node数据位置
~~~~~~~~~~~~~~↓核武器系列(不懂勿用)↓~~~~~~~~~~~~~~
(18) 国内一键加速脚本
(19) 一键修复内核版本
~~~~~~~~~~~~~~↑核武器系列(不懂勿用)↑~~~~~~~~~~~~~~
(66) 更新phala_Xtools
(88) 卸载Phala程序
(0) 退出脚本

==执行完1后可执行18加速 卡住可ctrl+c后再执行==
-----------------------------------------------------
EOF
                read -p "请输入要执行的选项: " input
                case $input in
                        1)
                                echo "---正在下载最新Phala脚本---"
                                download_phala
                                ;;
                        2)
                                echo "---正在检测您的系统环境---"
                                check_env
                                ;;
                        3)
                                echo "---正在安装Phala程序---"
                                install_phala
                                ;;
                        4)
                                echo "---正在启动Phala容器---"
                                start_phala
                                ;;
                        5)
                                echo "---正在停止Phala容器---"
                                stop_phala
                                ;;								
                        6)
                                echo "---正在查看状态&矿机公钥---"
                                check_status
                                ;;	
                        7)
                                echo "---正在查看Phala logs日志---"
                                check_logs
                                ;;
                        8)
                                echo "---正在查看抵押池和Gas配置---"
                                show_config
                                ;;
                        9)
                                echo "---正在修改抵押池和Gas配置---"
                                set_config
                                ;;
                        10)
                                echo "---正在更新Phala script脚本---"
                                update_script
                                ;;
                        11)
                                echo "---正在更新Phala镜像 不清空数据---"
                                update_phala
                                ;;
                        12)
                                echo "---正在更新Phala镜像 清空之前数据---"
                                update_clean_phala
                                ;;
                        13)
                                echo "---正在自定义Khala-node数据位置---"
                                set_khala_node
                                ;;								
                        14)
                                echo "---正在导入Khala-node镜像---"
                                import_khala_images
                                ;;
                        15)
                                echo "---正在导出Khala-node镜像---"
                                export_khala_images
                                ;;
                        18)
                                echo "---正在一键修改脚本为CN---"
                                set_cn
                                ;;	
                        19)
                                echo "---正在一键更新内核为5.8---"
                                set_kenel
                                ;;
                        66)
                                echo "---正在更新phala_Xtools---"
                                update_sh
                                ;;
                        88)
                                echo "---正在卸载phala程序---"
                                uninstall_phala
                                ;;
                        *)
                                exit 1
                                ;;
                esac
done
