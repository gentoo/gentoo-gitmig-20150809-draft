# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/publicfile/publicfile-0.52-r1.ebuild,v 1.10 2011/01/29 23:30:17 bangert Exp $

inherit eutils

IUSE="selinux"
DESCRIPTION="publish files through FTP and HTTP"
HOMEPAGE="http://cr.yp.to/publicfile.html"
SRC_URI="http://cr.yp.to/publicfile/${P}.tar.gz
	http://www.ohse.de/uwe/patches/${P}-filetype-diff
	http://www.publicfile.org/ftp-ls-patch"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 hppa ppc sparc x86"

RDEPEND="virtual/daemontools
	>=sys-apps/ucspi-tcp-0.83
	selinux? ( sec-policy/selinux-publicfile )
	!net-ftp/netkit-ftpd"

src_unpack() {
	unpack publicfile-0.52.tar.gz

	# filetypes in env using daemontools
	cd "${S}"
	epatch "${DISTDIR}"/${P}-filetype-diff

	# "normal" ftp listing
	epatch "${DISTDIR}"/ftp-ls-patch

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

pkg_preinst() {
	enewgroup nofiles
	enewuser ftp -1 -1 /home/public nofiles
	enewuser ftplog -1 -1 /home/public nofiles
}

pkg_postinst() {
	/usr/bin/publicfile-conf ftp ftplog /home/public `hostname`
	echo
	einfo "httpd and ftpd are serving out of /home/public."
	einfo "remember to start the servers with:"
	einfo "  ln -s /home/public/httpd /home/public/ftpd /service"
	echo
}
