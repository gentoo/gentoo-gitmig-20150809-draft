# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xvid/xvid-1.1.0_beta2-r1.ebuild,v 1.5 2005/08/07 01:54:05 gongloo Exp $

inherit eutils

MY_P=${PN}core-${PV/_beta/-beta}
DESCRIPTION="XviD, a high performance/quality MPEG-4 video de-/encoding solution"
HOMEPAGE="http://www.xvid.org/"
SRC_URI="http://downloads.xvid.org/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="doc altivec"

DEPEND="x86? ( >=dev-lang/nasm-0.98.36 )
	amd64? ( dev-lang/yasm )
	=sys-devel/autoconf-2.5*
	sys-devel/automake"

# This is used to avoid having build deps in DEPEND with an empty RDEPEND
RDEPEND="virtual/libc"

S="${WORKDIR}/${MY_P}/build/generic"

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}/${MY_P}"
	epatch "${FILESDIR}/${P}-altivec.patch"
	epatch "${FILESDIR}/${P}-amd64-gcc4.patch"

	cd ${S}
	WANT_AUTOCONF="2.5"
	./bootstrap.sh || die "Bootstrap failed"
}

src_compile() {
	econf \
		$(use_enable altivec) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	cd ${S}/../../
	dodoc AUTHORS ChangeLog README TODO doc/*

	if use userland_Darwin; then
		local mylib="$(basename $(ls ${D}/usr/$(get_libdir)/libxvidcore.*.dylib))"
		dosym ${mylib} /usr/$(get_libdir)/libxvidcore.dylib
	else
		local mylib="$(basename $(ls ${D}/usr/$(get_libdir)/libxvidcore.so*))"
		dosym ${mylib} /usr/$(get_libdir)/libxvidcore.so
		dosym ${mylib} /usr/$(get_libdir)/${mylib/.1}
	fi

	if use doc ; then
		dodoc CodingStyle doc/README
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
