# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pnetc/pnetc-0.5.8.ebuild,v 1.1 2003/06/17 08:37:59 scandium Exp $

MY_P=${P/c/C}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Portable .NET C library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu-pnet/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="=dev-libs/pnetlib-${PV}*"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING Changelog INSTALL README doc/HACKING
}
