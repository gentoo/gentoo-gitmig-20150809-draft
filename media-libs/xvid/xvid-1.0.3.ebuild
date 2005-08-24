# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xvid/xvid-1.0.3.ebuild,v 1.7 2005/08/24 18:00:03 agriffis Exp $

inherit eutils

MY_P=${PN}core-${PV/_rc/-rc}
DESCRIPTION="XviD, a high performance/quality MPEG-4 video de-/encoding solution"
HOMEPAGE="http://www.xvid.org/"
SRC_URI="http://files.xvid.org/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ia64 ~ppc ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND="x86? ( >=dev-lang/nasm-0.98.36 )"
RDEPEND=""

S="${WORKDIR}/${MY_P}/build/generic"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-DESTDIR.patch
	cd "${S}"/../..
	epatch "${FILESDIR}"/${PN}-1.0-ia64.patch
}

src_install() {
	make install DESTDIR="${D}" || die

	cd ${S}/../../
	dodoc AUTHORS ChangeLog README TODO doc/*

	local mylib="$(basename $(ls ${D}/usr/$(get_libdir)/libxvidcore.so*))"
	dosym ${mylib} /usr/$(get_libdir)/libxvidcore.so
	dosym ${mylib} /usr/$(get_libdir)/${mylib/.0}

	if use doc ; then
		dodoc CodingStyle doc/README
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
