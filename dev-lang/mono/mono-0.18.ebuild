# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono/mono-0.18.ebuild,v 1.1 2003/01/13 15:22:20 foser Exp $

#FIXME : we dont compile mcs from scratch right now

S=${WORKDIR}/${P}

IUSE=""
DESCRIPTION="Mono runtime, a C# compiler/interpreter"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz"
HOMEPAGE="http://www.go-mono.com/"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 -ppc"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.0
	>=dev-libs/boehm-gc-6.1"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die

	MAKEOPTS="-j1" emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS INSTALL ChangeLog COPYING.LIB NEWS README
	docinto docs 
	dodoc docs/*
}
