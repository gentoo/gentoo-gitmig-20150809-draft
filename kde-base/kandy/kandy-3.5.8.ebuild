# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kandy/kandy-3.5.8.ebuild,v 1.6 2008/01/31 15:32:19 ranger Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Communicating with your mobile phone"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkdepim libkdepim"
KMEXTRACTONLY="
	libkdepim/ "
