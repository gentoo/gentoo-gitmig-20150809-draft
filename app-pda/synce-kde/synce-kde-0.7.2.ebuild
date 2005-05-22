# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-kde/synce-kde-0.7.2.ebuild,v 1.7 2005/05/22 15:34:04 swegener Exp $

inherit kde

AGVER="agsync-0.2-pre"

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync. - KDE System Tray utility (formerly app-pda/rapip)"
HOMEPAGE="http://synce.sourceforge.net"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz
	avantgo? ( http://www.mechlord.ca/%7Elownewulf/${AGVER}.tgz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="avantgo"

DEPEND=">=app-pda/synce-0.8
	>=app-pda/synce-rra-0.8.9
	!app-pda/rapip"
RDEPEND=">=app-pda/synce-0.8
	>=app-pda/synce-rra-0.8.9"
need-kde 3.2

src_unpack() {
	kde_src_unpack

	# the default install location of iptables is /sbin/iptables
	cd ${S}/raki
	cp configdialogimpl.cpp configdialogimpl.cpp.orig
	sed "s:/usr/sbin/iptables:/sbin/iptables:" \
	configdialogimpl.cpp.orig > configdialogimpl.cpp
}

src_compile() {
	if use avantgo; then
		cd ${S}/../agsync-0.2-pre
		emake
		cd ${S}
		myconf="$myconf --with-agsync=${S}/../${AGVER}"
	fi
	kde_src_compile
}
