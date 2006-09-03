# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-3.5.2-r2.ebuild,v 1.12 2006/09/03 14:04:43 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="xcomposite"
RDEPEND="xcomposite? ( || ( (
			x11-libs/libXcomposite
			x11-libs/libXdamage
			) <x11-base/xorg-x11-7 )
		)"
DEPEND="${RDEPEND}
	xcomposite? ( || ( (
			x11-proto/compositeproto
			x11-proto/damageproto
			) <x11-base/xorg-x11-7 )
		)"

PATCHES="${FILESDIR}/kwin-3.5.2-alt_tab_and_focus_chain_fix.diff
	${FILESDIR}/kwin-3.5.2-parallel-make.diff"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
