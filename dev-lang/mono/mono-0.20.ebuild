# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono/mono-0.20.ebuild,v 1.2 2003/02/27 17:06:58 foser Exp $

#FIXME : we dont compile mcs from scratch right now

S=${WORKDIR}/${P}

IUSE=""
DESCRIPTION="Mono runtime and class librarier, a C# compiler/interpreter"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz"
HOMEPAGE="http://www.go-mono.com/"

LICENSE="LGPL-2"
SLOT="0"

KEYWORDS="x86 -ppc"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.0
	>=dev-libs/boehm-gc-6.1"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --with-gc=boehm || die

	MAKEOPTS="-j1" emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS ChangeLog COPYING.LIB NEWS README
	docinto docs 
	dodoc docs/*
}
