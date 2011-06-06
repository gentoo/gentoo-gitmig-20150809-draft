# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-iconthemes/kdeartwork-iconthemes-4.6.2.ebuild,v 1.5 2011/06/06 20:23:06 abcd Exp $

EAPI=3

KMNAME="kdeartwork"
KMMODULE="IconThemes"
inherit kde4-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

# Provides nuvola icon theme
RDEPEND="
	!x11-themes/nuvola
"
