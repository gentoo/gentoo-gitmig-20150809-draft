# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnetman/gnetman-0.0.1_pre20060522-r1.ebuild,v 1.1 2009/06/06 22:48:09 calchan Exp $

EAPI=2

MY_P="${PN}-22May06"

DESCRIPTION="A GNU Netlist Manipulation Library"
SRC_URI="http://www.viasic.com/opensource/${MY_P}.tar.gz"
HOMEPAGE="http://www.viasic.com/opensource/"

IUSE="doc examples"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/tk-8.3
	sci-electronics/geda-symbols"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/ sym / /' Makefile.in || die "sed failed"
	if use examples ; then
		sed -i -e "s:gEDA/sch/gnetman:doc/${PF}/examples:" \
			sch/Makefile.in || die "sed failed"
		sed -i -e "s:gEDA/examples/gnetman:doc/${PF}/examples:" \
			test/Makefile.in || die "sed failed"
	else
		sed -i -e 's/ sch test//' Makefile.in || die "sed failed"
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
	use doc && dodoc doc/*.{html,jpg}
}
