# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetc/pnetc-0.6.4.ebuild,v 1.1 2004/03/13 11:01:21 scandium Exp $

MY_P=${P/c/C}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Portable .NET C library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64"

IUSE=""

DEPEND="=dev-dotnet/pnetlib-${PV}*"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README doc/HACKING
}
