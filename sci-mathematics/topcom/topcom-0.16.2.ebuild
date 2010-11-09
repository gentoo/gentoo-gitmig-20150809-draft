# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/topcom/topcom-0.16.2.ebuild,v 1.1 2010/11/09 17:48:55 tomka Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="A package for computing Triangulations Of Point Configurations and Oriented Matroids."
SRC_URI="http://www.uni-bayreuth.de/departments/wirtschaftsmathematik/rambau/Software/TOPCOM-$PV.tar.gz
	doc? ( http://www.rambau.wm.uni-bayreuth.de/TOPCOM/TOPCOM-manual.html )"
HOMEPAGE="http://www.rambau.wm.uni-bayreuth.de/TOPCOM/"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="doc examples"

DEPEND=">=dev-libs/gmp-4.1-r1
	>=sci-libs/cddlib-094f"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/TOPCOM-${PV}

src_prepare () {
	# Don't compile internal GMP and CDD ...
	epatch "${FILESDIR}"/${PN}-${PV}-no-internal-libs.patch

	# ... and link in tree versions:
	append-libs -lgmp -lgmpxx -lcddgmp

	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README || die

	if use doc; then
		dohtml "${DISTDIR}"/TOPCOM-manual.html || die
	fi

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R "${S}"/examples/* "${D}"/usr/share/doc/${PF}/examples || die
	fi
}
