# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kglobalaccel/kglobalaccel-4.7.4.ebuild,v 1.2 2012/01/09 16:38:41 phajdan.jr Exp $

EAPI=4

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE's Global Shortcut Daemon"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

src_configure() {
	mycmakeargs=(
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_DESKTOP_FILE=NOTFOUND
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_PLUGIN=NOTFOUND
	)

	kde4-meta_src_configure
}
