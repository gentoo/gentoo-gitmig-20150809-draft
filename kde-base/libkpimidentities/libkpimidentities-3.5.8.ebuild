# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimidentities/libkpimidentities-3.5.8.ebuild,v 1.5 2008/01/30 17:24:34 ranger Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE PIM identities library"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/certmanager)
		$(deprange $PV $MAXKDEVER kde-base/libkdepim)"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkleopatra certmanager/lib/
	libkdepim libkdepim/"
KMEXTRACTONLY="
	libkdepim/
	certmanager/"
KMCOMPILEONLY="
	libemailfunctions/"
