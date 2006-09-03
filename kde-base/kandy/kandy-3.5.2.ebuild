# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kandy/kandy-3.5.2.ebuild,v 1.9 2006/09/03 16:07:27 kloeri Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Communicating with your mobile phone"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)"


KMCOPYLIB="
	libkdepim libkdepim"
KMEXTRACTONLY="
	libkdepim/ "