# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ml-pnet/ml-pnet-0.6.0.ebuild,v 1.3 2003/10/19 10:20:43 scandium Exp $

DESCRIPTION="Mono C# libraries for Portable .NET"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu-pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

IUSE=""

DEPEND="=dev-dotnet/pnetlib-${PV}*"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
