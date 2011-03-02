# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/gonvert/gonvert-0.2.23.ebuild,v 1.2 2011/03/02 21:19:45 jlec Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Unit conversion utility written in PyGTK"
HOMEPAGE="http://unihedron.com/projects/gonvert/gonvert.php"
SRC_URI="http://unihedron.com/projects/gonvert/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND="dev-python/pygtk:2"
RDEPEND="${DEPEND}"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-paths.patch"
}

src_install () {
	make install DESTDIR="${D}" prefix=/usr || die
	rm -fr "${D}/usr/share/doc/${PN}"
	dodoc doc/CHANGELOG doc/FAQ doc/README doc/THANKS doc/TODO
}
