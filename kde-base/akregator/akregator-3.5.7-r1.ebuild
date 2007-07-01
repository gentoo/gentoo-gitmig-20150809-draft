# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-3.5.7-r1.ebuild,v 1.1 2007/07/01 09:59:34 philantrop Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"

inherit kde-meta eutils

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)
	$(deprange $PV $MAXKDEVER kde-base/kontact)
	!net-www/akregator"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="libkdepim
	kontact/interfaces"
KMEXTRA="kontact/plugins/akregator"

PATCHES="${FILESDIR}/${P}-customcolors.diff"
