# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ml-pnet/ml-pnet-0.6.12.ebuild,v 1.6 2005/08/05 14:24:55 ferdy Exp $

DESCRIPTION="Mono C# libraries for Portable.NET"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="|| ( GPL-2 X11 )"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ia64 ppc ppc64 x86"
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
