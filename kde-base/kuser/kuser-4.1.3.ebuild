# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-4.1.3.ebuild,v 1.1 2008/11/09 01:41:29 scarabeus Exp $

EAPI="2"

KMNAME=kdeadmin
inherit kde4-meta

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND=">=kde-base/knotify-${PV}:${SLOT}"
