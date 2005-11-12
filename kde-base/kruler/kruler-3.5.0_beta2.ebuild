# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kruler/kruler-3.5.0_beta2.ebuild,v 1.3 2005/11/12 15:49:32 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=3.5.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A screen ruler for the K Desktop Environment"
KEYWORDS="~amd64 ~x86"
IUSE=""