# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmgtemp/wmgtemp-0.7.ebuild,v 1.5 2005/02/27 12:25:19 brix Exp $

IUSE=""

DESCRIPTION="CPU and SYS temperature dockapp"
HOMEPAGE="http://www.fluxcode.net"
SRC_URI="http://www.fluxcode.net/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 -ppc -sparc amd64"

DEPEND="sys-apps/lm-sensors
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}/src
	sed -i -e "s:-Wall -g:\$(CFLAGS):" Makefile
}

src_compile() {
	emake || die "parallel make failed"
}

src_install() {
	cd ${S}
	dodoc BUGS CREDITS INSTALL README TODO

	cd ${S}/src
	dobin wmgtemp
}
