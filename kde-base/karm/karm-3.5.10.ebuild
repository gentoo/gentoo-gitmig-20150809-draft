# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/karm/karm-3.5.10.ebuild,v 1.2 2009/05/31 21:08:34 nixnut Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE Time tracker tool"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND=">=kde-base/libkcal-${PV}:${SLOT}
	>=kde-base/kdepim-kresources-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}
	x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkcal_resourceremote kresources/remote"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	kresources/remote"

RESTRICT="test"
