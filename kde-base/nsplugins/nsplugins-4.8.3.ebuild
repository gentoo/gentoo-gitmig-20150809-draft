# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-4.8.3.ebuild,v 1.1 2012/05/03 20:07:44 johu Exp $

EAPI=4

KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	x11-libs/libXt
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep konqueror)
"

KMEXTRACTONLY="
	konqueror/settings/
"
