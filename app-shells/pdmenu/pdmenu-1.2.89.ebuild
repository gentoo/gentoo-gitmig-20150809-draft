# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdmenu/pdmenu-1.2.89.ebuild,v 1.2 2006/08/20 10:22:21 kloeri Exp $

DESCRIPTION="A simple console menu program"
HOMEPAGE="http://www.kitenet.net/programs/pdmenu/"
SRC_URI="mirror://debian/pool/main/p/pdmenu/pdmenu_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 mips"
IUSE="nls gpm examples"

DEPEND="sys-libs/slang
		gpm? ( sys-libs/gpm )
		nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}/"

src_compile() {
	econf \
		$(use_with gpm) \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	dodoc doc/ANNOUNCE doc/BUGS doc/COPYING doc/TODO

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	mv doc/pdmenu.man doc/pdmenu.1
	mv doc/pdmenurc.man doc/pdmenurc.5
	doman doc/pdmenu.1 doc/pdmenurc.5

	into /
	dobin pdmenu
}
