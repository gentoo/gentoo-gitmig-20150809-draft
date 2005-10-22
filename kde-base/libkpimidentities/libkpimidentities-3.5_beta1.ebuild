# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimidentities/libkpimidentities-3.5_beta1.ebuild,v 1.2 2005/10/22 07:45:49 halcy0n Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE PIM identities library"
KEYWORDS="~amd64 ~x86"
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
