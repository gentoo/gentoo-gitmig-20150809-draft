# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rarian/rarian-0.6.0.ebuild,v 1.1 2007/10/12 12:12:12 remi Exp $

inherit gnome2

DESCRIPTION="A documentation metadata library"
HOMEPAGE="www.freedesktop.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxslt"
DEPEND="${RDEPEND}
	!<app-text/scrollkeeper-9999"

GCONF=""

src_unpack() {
	# You cannot run src_unpack from gnome2; it will break the install by
	# calling gnome2_omf_fix
	unpack ${A}
	cd "${S}"
	elibtoolize ${ELTCONF}
}
