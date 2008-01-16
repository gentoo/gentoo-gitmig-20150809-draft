# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmsens/wmmsens-0.29.8.ebuild,v 1.1 2008/01/16 21:19:03 drac Exp $

inherit toolchain-funcs

DESCRIPTION="a dockapp for monitoring hardware sensors (sys-apps/lm_sensors)"
HOMEPAGE="http://www.digressed.net/wmmsens"
SRC_URI="http://www.digressed.net/${PN}/src/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/lm_sensors
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	sed -e 's:$(OBJS) $(LDFLAGS):$(LDFLAGS) $(OBJS) $(LIBS):g' \
		-e 's:LDFLAGS = -L/usr/X11R6/lib:LIBS =:' -e '/DELETE/q' \
		-i "${S}"/Makefile
}

src_compile() {
	emake CC="$(tc-getCXX)" OPTFLAGS="${CXXFLAGS}" || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc ../{ChangeLog,CREDITS,README,TODO}
}
