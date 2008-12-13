# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/localshell/localshell-1.2.ebuild,v 1.6 2008/12/13 23:58:49 flameeyes Exp $

inherit base

DESCRIPTION="Localshell allows per-user/group local control of shell execution."
HOMEPAGE="http://research.iat.sfu.ca/custom-software/localshell/"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
DEPEND="virtual/libc"
#RDEPEND=""

PATCHES=( "${FILESDIR}/${P}+gcc-4.3.patch" )

src_compile() {
	# this is a shell, it needs to be in /bin
	econf --bindir=/bin --sysconfdir=/etc || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}

pkg_postinst() {
	elog "Remember to add /bin/localshell to /etc/shells and create"
	elog "/etc/localshell.conf based on the included configuration examples"
}
