# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaliclock/xdaliclock-2.23.ebuild,v 1.1 2006/08/14 19:41:24 nelchael Exp $

IUSE=""

DESCRIPTION=" Dali Clock is a digital clock. When a digit changes, it melts into its new shape."
HOMEPAGE="http://www.jwz.org/xdaliclock/"
SRC_URI="http://www.jwz.org/${PN}/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc64"
LICENSE="BSD"
SLOT="0"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xextproto
		x11-proto/xproto )
	virtual/x11 )"

S="${WORKDIR}/${P}/X11"

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	make install_prefix="${D}" install || die "${PN} install failed"

	dodoc ../README
}
