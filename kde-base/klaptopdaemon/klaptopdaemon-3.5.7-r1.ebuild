# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.7-r1.ebuild,v 1.1 2007/08/17 07:59:42 philantrop Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-02.tar.bz2"

DESCRIPTION="KLaptopdaemon - KDE battery monitoring and management for laptops."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xscreensaver"

RDEPEND="x11-libs/libXtst"

DEPEND="${RDEPEND}
	xscreensaver? ( x11-libs/libXScrnSaver )
	x11-libs/libX11
	x11-proto/xproto
	virtual/os-headers"

PATCHES="${FILESDIR}/${P}-libXss-linking.patch
		${FILESDIR}/${P}-has_acpi_sleep.patch"
EPATCH_EXCLUDE="klaptopdaemon-3.5-suspend2+xsession-errors.diff"

src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"

	kde_src_compile
}
