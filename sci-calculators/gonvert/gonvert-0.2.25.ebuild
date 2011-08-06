# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/gonvert/gonvert-0.2.25.ebuild,v 1.1 2011/08/06 21:20:51 bicatali Exp $

EAPI=4

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

src_prepare () {
	epatch "${FILESDIR}"/0.2.23-paths.patch
}

src_install () {
	emake install DESTDIR="${D}" prefix=/usr
	rm -fr "${ED}/usr/share/doc/${PN}"
	dodoc doc/CHANGELOG doc/FAQ doc/README doc/THANKS doc/TODO
}
