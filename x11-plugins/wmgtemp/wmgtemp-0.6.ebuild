# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmgtemp/wmgtemp-0.6.ebuild,v 1.7 2004/01/04 18:36:48 aliz Exp $

IUSE=""

S="${WORKDIR}/${PN}"

DESCRIPTION="CPU and SYS temperature dockapp"
HOMEPAGE="http://www.fluxcode.net"
SRC_URI="http://www.fluxcode.net/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 -ppc -sparc amd64"

DEPEND="sys-apps/lm-sensors"

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
