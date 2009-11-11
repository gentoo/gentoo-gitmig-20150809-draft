# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-kde/synce-kde-0.9.1.ebuild,v 1.3 2009/11/11 02:05:38 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

AGVER="agsync-0.2-pre"

DESCRIPTION="Synchronize Windows CE devices with Linux.  KDE System Tray utility"
HOMEPAGE="http://synce.sourceforge.net/synce/kde/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz
	avantgo? ( http://www.mechlord.ca/%7Elownewulf/${AGVER}.tgz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="avantgo"

DEPEND=">=app-pda/synce-libsynce-0.9
	>=app-pda/synce-rra-0.9
	>=app-pda/orange-0.2
	>=app-arch/unshield-0.4
	app-pda/dynamite
	!app-pda/rapip"

need-kde 3.5

PATCHES=(
	"${FILESDIR}"/${P}+gcc-4.3.patch
)

src_unpack() {
	kde_src_unpack

	# the default install location of iptables is /sbin/iptables
	cd "${S}"/raki
	sed -i "s:/usr/sbin/iptables:/sbin/iptables:" configdialogimpl.cpp
}

src_compile() {
	if use avantgo; then
		cd "${S}"/../agsync-0.2-pre
		emake
		cd "${S}"
		myconf="$myconf --with-agsync=${S}/../${AGVER}"
	fi
	kde_src_compile
}
