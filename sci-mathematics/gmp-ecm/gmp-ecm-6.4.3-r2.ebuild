# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gmp-ecm/gmp-ecm-6.4.3-r2.ebuild,v 1.1 2012/11/25 07:36:31 patrick Exp $

EAPI=4
DESCRIPTION="Elliptic Curve Method for Integer Factorization"
HOMEPAGE="http://ecm.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/30965/${P}.tar.gz"

inherit eutils

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="custom-tune openmp"

DEPEND="dev-libs/gmp
	openmp? ( sys-devel/gcc[openmp] )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/ecm-${PV}

src_configure() {
	# --enable-shellcmd is broken
	econf $(use_enable openmp) || die
}

src_compile() {
	emake || die
	if use custom-tune; then
		./bench_mulredc | tail -n 4 >> `readlink ecm-params.h` || die
		make clean; emake || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	mkdir -p "${D}/usr/include/${PN}/"
	cp "${S}"/*.h "${D}/usr/include/${PN}" || die "Failed to copy headers" # needed by other apps like YAFU
}
