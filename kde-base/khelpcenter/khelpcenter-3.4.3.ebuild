# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-3.4.3.ebuild,v 1.3 2005/11/24 19:50:09 corsair Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE Help Center"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 sparc ~x86"
IUSE=""

KMEXTRA="doc/faq
	doc/glossary
	doc/quickstart
	doc/userguide
	doc/visualdict"
