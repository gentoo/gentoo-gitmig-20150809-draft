# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.8.7.ebuild,v 1.1 2008/10/09 14:36:11 voyageur Exp $

inherit gnustep-2

DESCRIPTION="A workspace manager for GNUstep"
HOMEPAGE="http://www.gnustep.org/experience/GWorkspace.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/usr-apps/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

#pdf support disabled, needs updated popplerkit patch
IUSE=""
DEPEND=">=gnustep-apps/systempreferences-1.0.1_p24791
	>=dev-db/sqlite-3.2.8"
RDEPEND="!gnustep-apps/desktop
	!gnustep-apps/recycler"

src_compile() {
	local myconf=""

	use kernel_linux && myconf="${myconf} --with-inotify"

	egnustep_env
	econf ${myconf}
	egnustep_make
}

src_install() {
	egnustep_env
	egnustep_install

	if use doc;
	then
		dodir /usr/share/doc/${PF}
		cp "${S}"/Documentation/*.pdf "${D}"/usr/share/doc/${PF}
	fi
}
