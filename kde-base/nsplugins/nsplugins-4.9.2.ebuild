# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-4.9.2.ebuild,v 1.2 2012/10/17 20:03:03 maekke Exp $

EAPI=4

KMNAME="kde-baseapps"
inherit kde4-meta pax-utils

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

src_install() {
	kde4-base_src_install

	# bug 419513
	pax-mark m "${ED}"/usr/bin/nspluginviewer
}
