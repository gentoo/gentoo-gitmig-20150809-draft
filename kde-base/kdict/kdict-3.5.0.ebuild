# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdict/kdict-3.5.0.ebuild,v 1.4 2005/12/12 17:28:33 josejx Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE dict client (for dict.org-like servers)"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""