# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kedit/kedit-3.5.0.ebuild,v 1.3 2005/12/04 12:34:45 kloeri Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: very simple text editor"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""