# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/localshell/localshell-1.1.ebuild,v 1.1 2005/07/18 04:50:47 robbat2 Exp $

DESCRIPTION="Localshell allows per-user/group local control of shell execution."
HOMEPAGE="http://research.iat.sfu.ca/custom-software/localshell/"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc"
#RDEPEND=""

src_compile() {
	# this is a shell, it needs to be in /bin
	econf --bindir=/bin --sysconfdir=/etc || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}

pkg_postinst() {
	einfo "Remember to add /bin/localshell to /etc/shells and create"
	einfo "/etc/localshell.conf based on the included configuration examples"
}
