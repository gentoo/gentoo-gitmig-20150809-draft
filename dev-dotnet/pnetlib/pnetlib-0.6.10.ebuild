# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetlib/pnetlib-0.6.10.ebuild,v 1.6 2005/08/05 14:26:00 ferdy Exp $

DESCRIPTION="Portable .NET C# library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 x86"
IUSE="truetype X"

DEPEND="=dev-dotnet/pnet-${PV}*
	X? ( virtual/x11 )
	truetype? ( virtual/xft )"

src_compile() {
	local lib_profile="default1.1"
	einfo "Using profile: ${lib_profile}"

	econf --with-profile=${lib_profile} \
		`use_enable truetype xft` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog HACKING INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
