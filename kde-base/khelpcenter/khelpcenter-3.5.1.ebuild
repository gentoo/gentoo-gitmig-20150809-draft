# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-3.5.1.ebuild,v 1.2 2006/03/28 00:00:33 agriffis Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE Help Center"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

KMEXTRA="doc/faq
	doc/glossary
	doc/quickstart
	doc/userguide
	doc/visualdict"
