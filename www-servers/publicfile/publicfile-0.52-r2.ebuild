# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/publicfile/publicfile-0.52-r2.ebuild,v 1.2 2011/01/29 23:30:17 bangert Exp $

EAPI="2"

inherit eutils toolchain-funcs

IUSE="selinux vanilla"
DESCRIPTION="publish files through FTP and HTTP"
HOMEPAGE="http://cr.yp.to/publicfile.html"
SRC_URI="http://cr.yp.to/publicfile/${P}.tar.gz
	http://www.ohse.de/uwe/patches/${P}-filetype-diff
	http://www.publicfile.org/ftp-ls-patch"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

RDEPEND="virtual/daemontools
	>=sys-apps/ucspi-tcp-0.83
	selinux? ( sec-policy/selinux-publicfile )
	!net-ftp/netkit-ftpd"

src_prepare() {
	# filetypes in env using daemontools
	use vanilla || epatch "${DISTDIR}"/${P}-filetype-diff

	# "normal" ftp listing
	use vanilla || epatch "${DISTDIR}"/ftp-ls-patch

	# fix for glibc-2.3.2 errno issue
	sed -i -e 's|extern int errno;|#include <errno.h>|' error.h
}

src_configure() {
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "/usr" > conf-home
}

src_compile() {
	emake || die "emake failed"
}

src_test() {
	:
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
	if [ ! -d /home/public/httpd ]; then
		einfo "Setting up server root in /home/public"
		if [ -d /home/public ]; then
			backupdir=public.old-$(date +%s)
			einfo "Serverroot exists... backing up to ${backupdir}"
			mv /home/public /home/${backupdir}
		fi
		/usr/bin/publicfile-conf ftp ftplog /home/public `hostname`
	fi
	echo
	einfo "httpd and ftpd are serving out of /home/public."
	einfo "Remember to start the servers with:"
	einfo "  ln -s /home/public/httpd /home/public/ftpd /service"
	echo
}
