# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/gonvert/gonvert-0.2.15.ebuild,v 1.1 2006/01/15 01:53:48 cryos Exp $

inherit eutils

DESCRIPTION="Unit conversion utility written in PyGTK"
HOMEPAGE="http://unihedron.com/projects/gonvert/gonvert.php"
SRC_URI="http://unihedron.com/projects/gonvert/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pygtk-2.8.2"

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/0.2.12-about.patch
}

src_install () {
	make install DESTDIR="${D}" prefix=/usr || die
	rm -fr "${D}/usr/share/doc/${PN}"
	dodoc doc/CHANGELOG doc/FAQ doc/README doc/THANKS doc/TODO
}
