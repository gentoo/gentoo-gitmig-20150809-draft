# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rarian/rarian-0.8.0.ebuild,v 1.2 2008/05/05 00:56:23 dirtyepic Exp $

inherit eutils gnome2

DESCRIPTION="A documentation metadata library"
HOMEPAGE="http://www.freedesktop.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/libxslt"
DEPEND="${RDEPEND}
	!<app-text/scrollkeeper-9999"

DOCS="ChangeLog NEWS README"

GCONF=""

src_unpack() {
	# You cannot run src_unpack from gnome2; it will break the install by
	# calling gnome2_omf_fix
	unpack ${A}
	cd "${S}"

	# Only GNU getopt supports long options
	# Scrollkeeper didn't support them, so we'll punt them for now
	epatch "${FILESDIR}/${PN}-0.6.0-posix-getopt.patch"

	elibtoolize ${ELTCONF}
}
