# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfax/kfax-3.5.0_beta2.ebuild,v 1.2 2005/10/22 06:57:01 halcy0n Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE G3/G4 fax viewer"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/tiff
$(deprange $PV $MAXKDEVER kde-base/kviewshell)"

KMEXTRA="kfaxview"
KMCOPYLIB="libkmultipage kviewshell"
KMEXTRACTONLY="kviewshell/"
KMCOMPILEONLY="kviewshell"
