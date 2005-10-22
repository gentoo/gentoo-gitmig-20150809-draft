# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kspy/kspy-3.5_beta1.ebuild,v 1.3 2005/10/22 07:31:08 halcy0n Exp $

KMNAME=kdesdk
MAXKDEVER=3.5.0_beta2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kspy - an utility intended to help developers examine the internal state of a Qt/KDE application"
KEYWORDS="~amd64 ~x86"
IUSE=""