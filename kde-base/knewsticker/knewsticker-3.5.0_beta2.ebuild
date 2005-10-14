# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker/knewsticker-3.5.0_beta2.ebuild,v 1.1 2005/10/14 18:41:56 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kicker plugin: rss news ticker"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
$(deprange 3.5_beta1 $MAXKDEVER kde-base/librss)"

KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"