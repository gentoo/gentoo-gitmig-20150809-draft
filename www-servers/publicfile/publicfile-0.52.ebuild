# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/publicfile/publicfile-0.52.ebuild,v 1.5 2009/01/03 18:42:40 bangert Exp $

inherit eutils

IUSE="selinux"
DESCRIPTION="publish files through FTP and HTTP"
SRC_URI="http://cr.yp.to/publicfile/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/publicfile.html"
KEYWORDS="x86 ppc sparc"
SLOT="0"

LICENSE="as-is"

RDEPEND=">=sys-process/daemontools-0.70
	>=sys-apps/ucspi-tcp-0.83
	selinux? ( sec-policy/selinux-publicfile )
	!net-ftp/netkit-ftpd"

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
	enewuser ftp -1 -1 /home/public nofiles
	enewuser ftplog -1 -1 /home/public nofiles
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
