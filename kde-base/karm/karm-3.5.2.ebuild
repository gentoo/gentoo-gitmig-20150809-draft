# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/karm/karm-3.5.2.ebuild,v 1.11 2006/10/17 09:25:25 flameeyes Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Time tracker tool"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)
	$(deprange $PV $MAXKDEVER kde-base/kdepim-kresources)
	$(deprange $PV $MAXKDEVER kde-base/libkdepim)
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
