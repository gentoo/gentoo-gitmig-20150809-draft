# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfax/kfax-3.4.0_beta2.ebuild,v 1.3 2005/03/07 14:26:22 cryos Exp $

KMNAME=kdegraphics
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE G3/G4 fax viewer"
KEYWORDS="~x86 ~amd64"
IUSE=""
OLDDEPEND="~kde-base/kviewshell-$PV"
DEPEND="media-libs/tiff
$(deprange $PV 3.4.0_rc1 kde-base/kviewshell)"

KMEXTRA="kfaxview"
KMCOPYLIB="libkmultipage kviewshell"
KMEXTRACTONLY="kviewshell/"