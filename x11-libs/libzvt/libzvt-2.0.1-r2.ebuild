# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libzvt/libzvt-2.0.1-r2.ebuild,v 1.15 2004/09/08 03:09:36 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="Zed's Virtual Terminal Library"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.5
	>=media-libs/libart_lgpl-2.3.9"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}

	# This patch fixes a bug related to the numeric keypad. See bug #9536
	epatch ${FILESDIR}/${P}-gentoo.diff
}
