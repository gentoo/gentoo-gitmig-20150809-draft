# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khotkeys/khotkeys-4.2.1.ebuild,v 1.3 2009/04/11 06:10:35 jer Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE: hotkey daemon"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXtst
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/kworkspace/
"

src_compile() {
	MAKEOPTS="${MAKEOPTS} -j1"

	kde4-meta_src_compile
}
