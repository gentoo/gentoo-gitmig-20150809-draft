# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ml-pnet/ml-pnet-0.6.8.ebuild,v 1.2 2004/08/08 10:26:41 scandium Exp $

DESCRIPTION="Mono C# libraries for Portable .NET"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
IUSE=""

DEPEND="=dev-dotnet/pnetlib-${PV}*"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
