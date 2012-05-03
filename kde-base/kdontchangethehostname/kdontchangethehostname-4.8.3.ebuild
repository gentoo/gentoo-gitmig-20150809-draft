# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdontchangethehostname/kdontchangethehostname-4.8.3.ebuild,v 1.1 2012/05/03 20:07:43 johu Exp $

EAPI=4

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Tool to inform KDE about a change in hostname"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-apps/xauth
"
