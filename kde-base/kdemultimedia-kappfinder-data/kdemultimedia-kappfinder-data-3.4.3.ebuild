# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kappfinder-data/kdemultimedia-kappfinder-data-3.4.3.ebuild,v 1.6 2005/12/10 06:30:35 chriswhite Exp $

KMNAME=kdemultimedia
KMMODULE=kappfinder-data
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kappfinder data from kdemultimedia"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""
