# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-desktoptheme/kdebase-desktoptheme-4.3.1.ebuild,v 1.4 2009/10/18 13:53:12 maekke Exp $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="desktoptheme"
inherit kde4-meta

DESCRIPTION="Oxygen KDE4 desktop theme."
IUSE=""
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 x86"

RDEPEND="
	!kdeprefix? ( !<kde-base/plasma-workspace-4.2.1[-kdeprefix] )
	kdeprefix? ( !<kde-base/plasma-workspace-4.2.1:${SLOT} )
"
