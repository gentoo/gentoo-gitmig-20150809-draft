# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
#$HEADER$

A=pure-ftpd-0.99.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Fast Production Quality FTP Server - Bug fixes backported from 0.99 . No new feature. Use this version on production servers."
SRC_URI="http://prdownloads.sourceforge.net/pureftpd/${A}"
HOMEPAGE="http://pureftpd.sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.75"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr  --with-throttling --with-virtualhosts \
	--with-ratios --with-largefile --with-cookie --with-welcomemsg \
	--with-altlog --with-ftpwho --with-uploadscript
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING ChangeLog README README.Configuration-File 
    dodoc README.Contrib README.LDAP README.Netfilter
    dodir /etc/pure-ftpd
    cp $S/configuration-file/*.pl ${D}/usr/sbin/
    cp $S/configuration-file/*.py ${D}/usr/sbin/
    cp $S/configuration-file/pure-ftpd.conf ${D}/etc/pure-ftpd/pure-ftpd.conf
    cp ${FILESDIR}/ftpusers ${D}/etc
    cp ${FILESDIR}/pure-ftpwho_html.py ${D}/usr/sbin/
    cp ${FILESDIR}/pure-ftp_xml_python.py ${D}/usr/sbin/
    dodir /home/ftp	
    dodir /home/ftp/pub
    dodir /home/ftp/incoming
    chown ftp.bin /home/ftp
    chown ftp.bin /home/ftp/incoming
    chmod 757 /home/ftp/incoming
    chown -R root.root /home/ftp/pub
    dosym /dev/null /etc/pure-ftpd/127.0.0.1
    cp ${FILESDIR}/welcome.msg /home/ftp/
    echo -e "\033[1;42m\033[1;33m Please do no forget to run, the following syntax : \033[0m"
    echo -e "\033[1;42m\033[1;33m ebuild pure-ftpd-0.99-r1.ebuild config \033[0m"
    echo -e "\033[1;42m\033[1;33m This will add the necessary post install config to your system. \033[0m"
    read
}

pkg_config() {
	echo "This config script will add pftpd lines to your /etc/xinetd.conf."
	echo "Press control-C to abort now OR hit Enter to continue."
	echo
	read
	cat ${FILESDIR}/pftpd.inetd >> ${ROOT}/etc/inetd.conf
	/etc/rc.d/init.d/svc-xinetd restart
	echo "Modifications applied."
}



