# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Kevin Koltzau <kevin@plop.org>
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-kde/synce-kde-0.6.1.ebuild,v 1.3 2004/03/14 17:22:21 mr_bones_ Exp $

inherit kde

need-kde 3.1

AGVER="agsync-0.2-pre"

IUSE="avantgo"
DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync. - KDE System Tray utility (formerly app-pda/rapip)"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz
	avantgo? (http://www.mechlord.ca/%7Elownewulf/${AGVER}.tgz)"
HOMEPAGE="http://synce.sourceforge.net"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86"

newdepend ">=app-pda/synce-0.8
	>=app-pda/synce-rra-0.8
	!app-pda/rapip"

src_unpack() {
	kde_src_unpack

	# the default install location of iptables is /sbin/iptables
	cd ${S}/raki
	cp configdialogimpl.cpp configdialogimpl.cpp.orig
	sed "s:/usr/sbin/iptables:/sbin/iptables:" \
	configdialogimpl.cpp.orig > configdialogimpl.cpp
}

src_compile() {
	if [ `use avantgo` ]; then
		cd ${S}/../agsync-0.2-pre
		emake
		cd ${S}
		myconf="$myconf --with-agsync=${S}/../${AGVER}"
	fi
	kde_src_compile
}
