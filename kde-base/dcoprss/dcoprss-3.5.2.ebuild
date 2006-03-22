# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcoprss/dcoprss-3.5.2.ebuild,v 1.1 2006/03/22 20:14:54 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: RSS server and client for DCOP"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange 3.5.0 $MAXKDEVER kde-base/librss)"


KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"
