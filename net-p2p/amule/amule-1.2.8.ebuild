# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-1.2.8.ebuild,v 1.4 2004/10/06 16:53:02 pythonhead Exp $

inherit wxwidgets

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aMule, the all-platform eMule p2p client"
HOMEPAGE="http://www.amule.org"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="debug nls remote gtk2"

DEPEND=">=x11-libs/wxGTK-2.4.2-r2
	>=net-misc/curl-7.11.0
	>=sys-libs/zlib-1.2.1
	!net-p2p/xmule"

src_compile() {
	if ! use gtk2 ; then
		need-wxwidgets gtk || die "gtk version of wxGTK not found"
	else
		need-wxwidgets gtk2 || die "gtk2 version of wxGTK not found"
	fi
	econf `use_enable nls` \
	`use_enable remote amulecmd` \
	`use_enable debug` || die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
}
