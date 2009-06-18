# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krfb/krfb-3.5.10.ebuild,v 1.5 2009/06/18 03:07:46 jer Exp $

KMNAME=kdenetwork
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="VNC-compatible server to share KDE desktops"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility slp"

DEPEND="slp? ( net-libs/openslp )
	x11-libs/libXtst"

src_compile() {
	myconf="$myconf $(use_enable slp)"
	kde-meta_src_compile
}
