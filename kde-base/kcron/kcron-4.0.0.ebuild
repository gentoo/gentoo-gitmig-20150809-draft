# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcron/kcron-4.0.0.ebuild,v 1.1 2008/01/17 23:38:05 philantrop Exp $

EAPI="1"

KMNAME=kdeadmin
inherit kde4-meta

DESCRIPTION="KDE Task Scheduler"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="virtual/cron
	|| ( >=kde-base/knotify-${PV}:${SLOT}
		>=kde-base/kdebase-${PV}:${SLOT} )"
