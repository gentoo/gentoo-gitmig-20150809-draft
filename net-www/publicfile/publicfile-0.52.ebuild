# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/publicfile/publicfile-0.52.ebuild,v 1.16 2004/07/27 10:47:24 tigger Exp $

inherit eutils

IUSE="selinux"
S=${WORKDIR}/${P}
DESCRIPTION="publish files through FTP and HTTP"
SRC_URI="http://cr.yp.to/publicfile/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/publicfile.html"
KEYWORDS="x86 ppc sparc"
SLOT="0"

LICENSE="as-is"

RDEPEND=">=sys-apps/daemontools-0.70
	>=sys-apps/ucspi-tcp-0.83
	selinux? ( sec-policy/selinux-publicfile )"

src_compile() {
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr" > conf-home

	# fix for glibc-2.3.2 errno issue
	mv error.h error.h.orig
	sed -e 's|extern int errno;|#include <errno.h>|' <error.h.orig >error.h

	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe ftpd httpd
	newexe configure publicfile-conf
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}

pkg_preinst() {
	enewgroup nofiles
	enewuser ftp -1 /bin/false /home/public nofiles
	enewuser ftplog -1 /bin/false /home/public nofiles
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
