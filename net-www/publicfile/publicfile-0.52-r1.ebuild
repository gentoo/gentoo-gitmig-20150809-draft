# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/publicfile/publicfile-0.52-r1.ebuild,v 1.1 2003/12/30 15:08:32 mholzer Exp $

inherit eutils

DESCRIPTION="publish files through FTP and HTTP"
HOMEPAGE="http://cr.yp.to/publicfile.html"
SRC_URI="http://cr.yp.to/publicfile/${P}.tar.gz
	http://www.ohse.de/uwe/patches/${P}-filetype-diff
	http://www.publicfile.org/ftp-ls-patch"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=sys-apps/daemontools-0.70
	>=sys-apps/ucspi-tcp-0.83"

src_unpack() {
	unpack publicfile-0.52.tar.gz

	# filetypes in env using daemontools
	cd ${S}
	epatch ${DISTDIR}/${P}-filetype-diff

	# "normal" ftp listing
	epatch ${DISTDIR}/ftp-ls-patch

	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr" > conf-home

	# fix for glibc-2.3.2 errno issue
	sed -i -e 's|extern int errno;|#include <errno.h>|' error.h
}

src_compile() {
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
