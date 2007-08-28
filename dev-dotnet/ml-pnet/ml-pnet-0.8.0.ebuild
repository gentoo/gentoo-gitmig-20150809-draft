# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ml-pnet/ml-pnet-0.8.0.ebuild,v 1.2 2007/08/28 23:39:13 jurek Exp $

DESCRIPTION="Mono C# libraries for Portable.NET"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="http://www.southern-storm.com.au/download/${P}.tar.gz
		 http://download.savannah.gnu.org/releases/dotgnu-pnet/${P}.tar.gz"

LICENSE="|| ( GPL-2 X11 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="=dev-dotnet/pnetlib-${PV}*"

src_compile() {
	local lib_profile="framework1.1"
	elog "Using profile: ${lib_profile}"

	econf --with-profile=${lib_profile} || die "econf failed"

	# Prevents build failure due to length of argument list (bug #167442)
	find ${S} -name Makefile | xargs sed -i -e "s#${WORKDIR}#\${top_srcdir}/..#"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
