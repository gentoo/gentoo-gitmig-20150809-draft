# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/librss/librss-3.5_beta1.ebuild,v 1.4 2005/11/12 15:49:35 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=3.5.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE rss library"
KEYWORDS="~amd64 ~x86"
IUSE=""