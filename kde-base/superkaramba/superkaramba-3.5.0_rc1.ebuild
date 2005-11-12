# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:36 danarmak Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!x11-misc/superkaramba"

