# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-wallpapers/kdebase-wallpapers-4.3.0.ebuild,v 1.1 2009/08/04 00:12:52 wired Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="wallpapers"
inherit kde4-meta

DESCRIPTION="KDE wallpapers"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	!kdeprefix? ( !kde-base/kde-wallpapers[-kdeprefix] )
	kdeprefix? ( !kde-base/kde-wallpapers:${SLOT} )
"
