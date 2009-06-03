# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.10.ebuild,v 1.3 2009/06/03 14:45:41 ranger Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-02.tar.bz2"

DESCRIPTION="KLaptopdaemon - KDE battery monitoring and management for laptops."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xscreensaver"

RDEPEND="x11-libs/libXtst
	xscreensaver? ( x11-libs/libXScrnSaver )"

DEPEND="${RDEPEND}
	virtual/os-headers"

EPATCH_EXCLUDE="klaptopdaemon-3.5-suspend2+xsession-errors.diff
	klaptopdaemon-3.5-lock-and-hibernate.diff"

src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"

	kde_src_compile
}
