# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xvid/xvid-1.0.0_rc4.ebuild,v 1.1 2004/04/26 22:47:51 vapier Exp $

inherit eutils

MY_P=${PN}core-${PV/_rc/-rc}
S="${WORKDIR}/${MY_P}/build/generic"
DESCRIPTION="XviD, a high performance/quality MPEG-4 video de-/encoding solution."
HOMEPAGE="http://www.xvid.org/"
SRC_URI="http://files.xvid.org/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE="doc"

DEPEND="virtual/glibc
	x86? ( >=dev-lang/nasm-0.98.36 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-DESTDIR.patch
}

src_install() {
	make install DESTDIR=${D} || die

	cd ${S}/../../
	dodoc AUTHORS ChangeLog README TODO doc/*

	local mylib="$(basename $(ls ${D}/usr/lib/libxvidcore.so*))"
	dosym ${mylib} /usr/lib/libxvidcore.so
	dosym ${mylib} /usr/lib/${mylib/.0}

	if use doc ; then
		dodoc CodingStyle doc/README
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
