# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfax/kfax-3.4.1.ebuild,v 1.8 2005/08/08 20:21:48 kloeri Exp $

KMNAME=kdegraphics
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE G3/G4 fax viewer"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""
OLDDEPEND="~kde-base/kviewshell-$PV"
DEPEND="media-libs/tiff
$(deprange $PV 3.4.2 kde-base/kviewshell)"

KMEXTRA="kfaxview"
KMCOPYLIB="libkmultipage kviewshell"
KMEXTRACTONLY="kviewshell/"