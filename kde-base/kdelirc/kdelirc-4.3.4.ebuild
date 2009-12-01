# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelirc/kdelirc-4.3.4.ebuild,v 1.1 2009/12/01 10:23:16 wired Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE frontend for the Linux Infrared Remote Control system"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug +handbook"

RDEPEND="
	!kde-misc/kdelirc
	app-misc/lirc
"
