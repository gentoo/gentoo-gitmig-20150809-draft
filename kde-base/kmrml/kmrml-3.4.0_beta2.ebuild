# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmrml/kmrml-3.4.0_beta2.ebuild,v 1.2 2005/02/27 20:21:37 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KIO and konqueror plugins for MRML - an image indexing service"
KEYWORDS="~x86"
IUSE=""