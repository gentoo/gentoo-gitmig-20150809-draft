# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-4.0.0.ebuild,v 1.1 2008/01/18 01:15:11 ingmar Exp $

EAPI="1"

KMNAME=kdeadmin
inherit kde4-meta

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="|| ( >=kde-base/knotify-${PV}:${SLOT}
		>=kde-base/kdebase-${PV}:${SLOT} )"
