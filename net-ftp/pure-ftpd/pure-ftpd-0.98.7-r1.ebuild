# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Fast Production Quality FTP Server"
SRC_URI="http://prdownloads.sourceforge.net/pureftpd/${A}"
HOMEPAGE="http://pureftpd.sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.75"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr  --with-throttling --with-virtualhosts\
	--with-ratios --with-largefile
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING ChangeLog README README.Configuration-File 
    dodoc README.Contrib README.LDAP README.Netfilter
    dodir /etc/pure-ftpd
}

pkg_config() {
	echo "This config script will add pftpd lines to your /etc/xinetd.conf."
	echo "Press control-C to abort, hit Enter to continue."
	echo
	read
	cat ${FILESDIR}/pftpd.xinetd >> ${ROOT}etc/xinetd.conf
	ln -s /dev/null /etc/pure-ftpd/127.0.0.1
	/etc/rc.d/init.d/svc-xinetd restart
	echo "Modifications applied."
}



