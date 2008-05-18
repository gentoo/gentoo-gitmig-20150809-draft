# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krfb/krfb-3.5.9.ebuild,v 1.7 2008/05/18 16:31:47 maekke Exp $

KMNAME=kdenetwork
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="VNC-compatible server to share KDE desktops"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility slp"

DEPEND="slp? ( net-libs/openslp )
	x11-libs/libXtst"
RDEPEND="${DEPEND}"

src_compile() {
	myconf="$myconf $(use_enable slp)"
	kde-meta_src_compile
}
