# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/publicfile/publicfile-0.52.ebuild,v 1.5 2002/08/14 15:50:34 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="publish files through FTP and HTTP"
SRC_URI="http://cr.yp.to/publicfile/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/publicfile.html"
KEYWORDS="x86 ppc"
SLOT="0"

LICENSE="as-is"

RDEPEND=">=sys-apps/daemontools-0.70
	>=sys-apps/ucspi-tcp-0.83"

src_compile() {
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr" > conf-home
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe ftpd httpd
	newexe configure publicfile-conf
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}

pkg_setup() {
	groupadd nofiles
	id ftp || useradd -g nofiles -d /home/public ftp
	id ftplog || useradd -g nofiles -d /home/public ftplog
}

pkg_postinst() {
	/usr/bin/publicfile-conf ftp ftplog /home/public `hostname`
	echo
	echo -e "\e[32;01m httpd and ftpd are serving out of /home/public.\033[0m"
	echo -e "\e[32;01m remember to start the servers with:\033[0m"
	echo -e "\e[32;01m   ln -s /home/public/httpd /home/public/home/ftpd /service\033[0m"
	echo
}

pkg_postrm() {
        userdel ftplog
}
