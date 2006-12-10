# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ml-pnet/ml-pnet-0.7.0.ebuild,v 1.4 2006/12/10 10:26:49 corsair Exp $

DESCRIPTION="Mono C# libraries for Portable.NET"
HOMEPAGE="http://www.dotgnu.org/"
#SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"
SRC_URI="http://www.southern-storm.com.au/download/${P}.tar.gz"

LICENSE="|| ( GPL-2 X11 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="=dev-dotnet/pnetlib-${PV}*"

src_compile() {
	local lib_profile="framework1.1"
	einfo "Using profile: ${lib_profile}"

	econf --with-profile=${lib_profile} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
