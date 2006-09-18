# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpersonalizer/kpersonalizer-3.5.4-r1.ebuild,v 1.1 2006/09/18 00:56:10 carlo Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-03.tar.bz2"

DESCRIPTION="KDE user settings wizard."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

KMEXTRACTONLY="libkonq"

