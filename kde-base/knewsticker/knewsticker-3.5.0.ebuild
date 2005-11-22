# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker/knewsticker-3.5.0.ebuild,v 1.1 2005/11/22 22:14:09 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kicker plugin: rss news ticker"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
$(deprange $PV $MAXKDEVER kde-base/librss)"

KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"