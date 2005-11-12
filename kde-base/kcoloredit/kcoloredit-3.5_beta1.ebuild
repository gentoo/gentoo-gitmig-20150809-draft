# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcoloredit/kcoloredit-3.5_beta1.ebuild,v 1.4 2005/11/12 15:49:24 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=3.5.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE color selector/editor"
KEYWORDS="~amd64 ~x86"
IUSE=""