# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcron/kcron-4.0.1.ebuild,v 1.3 2008/03/04 04:14:30 jer Exp $

EAPI="1"

KMNAME=kdeadmin
inherit kde4-meta

DESCRIPTION="KDE Task Scheduler"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug htmlhandbook"

RDEPEND="virtual/cron
	>=kde-base/knotify-${PV}:${SLOT}"
