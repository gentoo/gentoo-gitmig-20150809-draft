# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ml-pnet/ml-pnet-0.6.6.ebuild,v 1.5 2004/06/24 22:04:09 agriffis Exp $

DESCRIPTION="Mono C# libraries for Portable .NET"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"

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
