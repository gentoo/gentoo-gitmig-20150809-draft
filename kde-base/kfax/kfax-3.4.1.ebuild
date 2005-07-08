# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfax/kfax-3.4.1.ebuild,v 1.6 2005/07/08 04:06:06 weeve Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE G3/G4 fax viewer"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
OLDDEPEND="~kde-base/kviewshell-$PV"
DEPEND="media-libs/tiff
$(deprange $PV $MAXKDEVER kde-base/kviewshell)"

KMEXTRA="kfaxview"
KMCOPYLIB="libkmultipage kviewshell"
KMEXTRACTONLY="kviewshell/"