# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vlock/vlock-1.3-r1.ebuild,v 1.16 2004/10/26 12:12:00 pyrania Exp $

DESCRIPTION="A console screen locker"
HOMEPAGE="ftp://ftp.ibiblio.org/pub/Linux/utils/console/"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/console/vlock-1.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha amd64 ia64 ~sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin vlock || die
	# Setuid root is required to unlock a screen with root's password.
	# This is "safe" because vlock drops privs ASAP; read the README
	# for more information.
	fperms 4711 /usr/bin/vlock
	doman vlock.1
	dodoc README
	insinto /etc/pam.d
	newins ${FILESDIR}/vlock.pamd vlock
}
