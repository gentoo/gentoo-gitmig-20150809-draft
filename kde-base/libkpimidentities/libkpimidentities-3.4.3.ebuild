# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimidentities/libkpimidentities-3.4.3.ebuild,v 1.8 2006/03/26 16:25:35 agriffis Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE PIM identities library"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/certmanager)
$(deprange $PV $MAXKDEVER kde-base/libkdepim)"
OLDDEPEND="~kde-base/certmanager-$PV ~kde-base/libkdepim-$PV"

KMCOPYLIB="
	libkleopatra certmanager/lib/
	libkdepim libkdepim/"
KMEXTRACTONLY="
	libkdepim/
	certmanager/"
KMCOMPILEONLY="
	libemailfunctions/"
