BASE_PATH=$(cd `dirname $0`;pwd)

setting(){
read -p "��ѡ����Ӫ�� 
0. У԰�� 1. �ƶ� 2. ���� 3. ��ͨ 
" isp

case $isp in
	1 ) isp="�ƶ�";;
	2 ) isp="����";;
	3 ) isp="@union";;
	*) isp="";;
esac

read -p "�������˺�: " user
read -p "����������: " password

# ����ԭ�˺� ����
sed -i "4c user=\"$user$isp\"" "$BASE_PATH/login.sh"
sed -i "5c pwd=\"$password\"" "$BASE_PATH/login.sh"
echo "�޸��û��ɹ�
�˺�: $user$isp
����: $password"
}

addCrontab(){
crontab="/etc/crontabs/root"
echo "*/5 * * * * cd $BASE_PATH && ./login.sh" >> $crontab
echo "��Ӷ�ʱ����ɹ�,������ʱ����"
/etc/init.d/cron restart
crontab -l
}

downloadScript(){
curl -LJO "https://cdn.jsdelivr.net/gh/Ayouuuu/hniu-surfing-internet@main/login.sh"
curl -LJO "https://cdn.jsdelivr.net/gh/Ayouuuu/hniu-surfing-internet@main/logout.sh"
}

update(){
echo "���ڸ������..."
opkg update
echo "��������ɹ������ڰ�װ�������"
opkg install curl cronie
echo "������װ�ɹ�,������������"
downloadScript
echo "���������سɹ�!"
echo "alias hniu='bash "$BASE_PATH/run.sh"'" >> ~/.bashrc
source "~/.bashrc"
echo "��ӻ��������ɹ�! ���� hniu �ɿ�ݴ򿪲˵�"
}

login(){
bash "$BASE_PATH/login.sh"
}

logout(){
bash "$BASE_PATH/logout.sh"
}

run(){
read -p "��ѡ��װģʽ
0) Ĭ��: ��ʼ��
1) �����˻���Ϣ
2����½
3) �ǳ�
4) ���½ű�
" mode
case $mode in
	4 )
		downloadScript;;
	3 )
		logout;;
	2 )
		login;;
	1 )
		setting;;
	0 )
		update
		addCrontab;;
	*)
		exit 0;;
esac
}

run