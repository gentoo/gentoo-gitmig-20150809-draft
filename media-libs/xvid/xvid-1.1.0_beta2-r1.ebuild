# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xvid/xvid-1.1.0_beta2-r1.ebuild,v 1.9 2006/01/03 23:14:27 kloeri Exp $

inherit eutils fixheadtails

MY_P=${PN}core-${PV/_beta/-beta}
DESCRIPTION="XviD, a high performance/quality MPEG-4 video de-/encoding solution"
HOMEPAGE="http://www.xvid.org/"
SRC_URI="http://downloads.xvid.org/downloads/${MY_P}.tar.bz2
	mirror://gentoo/${PN}-1.1.0-noexec-stack.patch.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="doc altivec"

DEPEND="x86? ( >=dev-lang/nasm-0.98.36 )
	amd64? ( dev-lang/yasm )
	=sys-devel/autoconf-2.5*
	sys-devel/automake"
RDEPEND=""

S=${WORKDIR}/${MY_P}/build/generic

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}"/${MY_P}
	epatch "${FILESDIR}"/${P}-altivec.patch
	epatch "${FILESDIR}"/${P}-amd64-gcc4.patch
	epatch "${WORKDIR}/${PN}-1.1.0-noexec-stack.patch"

	cd "${S}"
	ht_fix_file bootstrap.sh
	WANT_AUTOCONF="2.5" ./bootstrap.sh || die "Bootstrap failed"
}

src_compile() {
	econf $(use_enable altivec) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	cd "${S}"/../../
	dodoc AUTHORS ChangeLog README TODO doc/*

	if [[ ${CHOST} == *-darwin* ]]; then
		local mylib=$(basename $(ls "${D}"/usr/$(get_libdir)/libxvidcore.*.dylib))
		dosym ${mylib} /usr/$(get_libdir)/libxvidcore.dylib
	else
		local mylib=$(basename $(ls "${D}"/usr/$(get_libdir)/libxvidcore.so*))
		dosym ${mylib} /usr/$(get_libdir)/libxvidcore.so
		dosym ${mylib} /usr/$(get_libdir)/${mylib/.1}
	fi

	if use doc ; then
		dodoc CodingStyle doc/README
		docinto examples
		dodoc examples/*
	fi
}
