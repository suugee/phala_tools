#!/bin/bash

download_phala(){
sudo apt-get -y install wget && apt-get -y install unzip && wget https://github.com/Phala-Network/solo-mining-scripts/archive/poc5.zip && unzip poc5.zip
}

sgx_enable(){
cd ~/solo-mining-scripts-poc5 && sudo chmod +x sgx_enable && sudo ./sgx_enable
}

install_phala(){
cd ~/solo-mining-scripts-poc5 && sudo chmod +x install.sh && sudo ./install.sh cn && sudo phala install
}

set_phala(){
sudo phala config set
}

check_phala(){
sudo phala config show
}

start_phala(){
sudo phala start
}

stop_phala(){
sudo phala stop
}

update_phala(){
sudo phala update clean
}

check_status(){
sudo phala status
}

uninstall_phala(){
sudo phala uninstall
}

all(){
while true 
        do
cat << EOF
-----------------------------------------------------
         -------------------------------------  
		PHALA快捷搭建脚本
			  苏格QQ6559178
         ------------------------------------- 
==只为流程化引导官方脚本操作 镜像无任何修改可放心使用==
(1) 下载最新版PHALA脚本(必备)
(2) 检测硬件是否支持SGX
(3) 安装PHALA脚本(必需)
(4) 配置PHALA参数+信任等级评分
(5) 查看PHALA配置
(6) 启动PHALA程序
(7) 停止PHALA程序
(8) 更新PHALA程序(会清空数据)
(9) 查看状态&矿机公钥
(88) 卸载PHALA程序
(0) 退出本脚本
==前4步需按顺序执行,过程中卡住可ctrl+c取消后重新执行==
-----------------------------------------------------
EOF
                read -p "请输入要执行的选项: " input
                case $input in
                        1)
                                echo "下载最新版本phala脚本"
                                download_phala
                                ;;
                        2)
                                echo "检测硬件是否支持SGX"
                                sgx_enable
                                ;;
                        3)
                                echo "安装phala脚本"
                                install_phala
                                ;;
                        4)
                                echo "配置phala参数"
                                set_phala
                                ;;
                        5)
                                echo "查看phala配置 自动获取信任等级"
                                check_phala
                                ;;
                        6)
                                echo "启动phala程序"
                                start_phala
                                ;;
                        7)
                                echo "停止phala程序"
                                stop_phala
                                ;;
                        8)
                                echo "更新phala脚本和主程序 会清除之前的镜像和数据"
                                update_phala
                                ;;
                        9)
                                echo "查看运行状态和矿机公钥 退出使用CTRL+C"
                                check_status
                                ;;
                        88)
                                echo "卸载phala程序"
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
         -------------------------------------  
		PHALA快捷搭建脚本
			  苏格QQ6559178
         ------------------------------------- 
==只为流程化引导官方脚本操作 镜像无任何修改可放心使用==
<1> 下载最新版PHALA脚本(必备)
<2> 检测硬件是否支持SGX
<3> 安装PHALA脚本(必需)
<4> 配置矿机参数+信任等级评分
<5> 查看PHALA配置
<6> 启动PHALA程序
<7> 停止PHALA程序
<8> 更新PHALA程序(会清空数据)
<9> 查看PHALA状态(矿机公钥)
<88> 卸载PHALA程序
<0> Exit退出本脚本
==前4步需按顺序执行,过程中卡住可ctrl+c取消后重新执行==
-----------------------------------------------------
EOF
                read -p "请输入要执行的选项: " input
                case $input in
                        1)
                                echo "下载最新版本phala脚本"
                                download_phala
                                ;;
                        2)
                                echo "检测硬件是否支持SGX"
                                sgx_enable
                                ;;
                        3)
                                echo "安装phala脚本"
                                install_phala
                                ;;
                        4)
                                echo "配置phala参数"
                                set_phala
                                ;;
                        5)
                                echo "查看phala配置"
                                check_phala
                                ;;
                        6)
                                echo "启动phala程序"
                                start_phala
                                ;;
                        7)
                                echo "停止phala程序"
                                stop_phala
                                ;;
                        8)
                                echo "更新phala脚本和主程序 会清除之前的镜像和数据"
                                update_phala
                                ;;
                        9)
                                echo "查看运行状态和矿机公钥 退出使用CTRL+C"
                                check_status
                                ;;
                        88)
                                echo "卸载phala程序"
                                uninstall_phala
                                ;;
                        *)
                                exit 1
                                ;;
                esac
done
