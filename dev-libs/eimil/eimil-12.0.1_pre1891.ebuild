# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eimil/eimil-12.0.1_pre1891.ebuild,v 1.2 2004/10/17 09:23:09 dholm Exp $

inherit iiimf

DESCRIPTION="A generic library for EIMIL services for IIIMF"

KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="sys-devel/automake
	sys-devel/autoconf"
RDEPEND="virtual/libc"

S="${WORKDIR}/${IMSDK}/lib/EIMIL"

src_install() {

	einstall || die

	dolib.a .libs/libEIMIL.a
	sed -e "s%libdir=''%libdir='/usr/lib'%" \
		-e "s%installed=no%installed=yes%" \
		.libs/libEIMIL.la > ${T}/libEIMIL.la
	insinto /usr/lib
	doins ${T}/libEIMIL.la
	fperms 755 /usr/lib/libEIMIL.la

	dodoc ChangeLog
}
