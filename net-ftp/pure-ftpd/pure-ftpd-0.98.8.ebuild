# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
$HEADER$

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Fast Production Quality FTP Server - Bug fixes backported from 0.99 . No new feature. Use this version on production servers."
SRC_URI="http://prdownloads.sourceforge.net/pureftpd/${A}"
HOMEPAGE="http://pureftpd.sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.75"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr  --with-throttling --with-virtualhosts\
	--with-ratios --with-largefile --with-cookie --with-welcomemsg 
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
    echo "Please do no forget to run, the following syntax :"
    echo "ebuild pure-ftpd-0.98.8.ebuild config"
    echo "This will add the necessary post install config to your system."
}

pkg_config() {
	echo "This config script will add pftpd lines to your /etc/xinetd.conf."
	echo "Press control-C to abort, hit Enter to continue."
	echo
	read
	cat ${FILESDIR}/pftpd.inetd >> ${ROOT}etc/inetd.conf
	ln -s /dev/null /etc/pure-ftpd/127.0.0.1
	/etc/rc.d/init.d/svc-xinetd restart
	echo "Modifications applied."
}



