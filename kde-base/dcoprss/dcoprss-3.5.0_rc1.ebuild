# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcoprss/dcoprss-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:23 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: RSS server and client for DCOP"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange 3.5_beta1 $MAXKDEVER kde-base/librss)"


KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"
