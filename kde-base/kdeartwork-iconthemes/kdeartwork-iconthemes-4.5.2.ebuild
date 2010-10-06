# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-iconthemes/kdeartwork-iconthemes-4.5.2.ebuild,v 1.1 2010/10/06 09:17:19 alexxy Exp $

EAPI="3"

KMNAME="kdeartwork"
KMMODULE="IconThemes"
inherit kde4-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Provides nuvola icon theme
RDEPEND="
	!kdeprefix? ( !x11-themes/nuvola )
"
