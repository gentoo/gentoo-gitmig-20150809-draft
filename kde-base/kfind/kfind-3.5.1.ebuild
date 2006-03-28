# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-3.5.1.ebuild,v 1.2 2006/03/27 23:54:30 agriffis Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE file find utility"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkonq)"


KMCOPYLIB="libkonq libkonq"
