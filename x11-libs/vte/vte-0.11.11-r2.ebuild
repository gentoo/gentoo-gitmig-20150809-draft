# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.11.11-r2.ebuild,v 1.8 2005/04/02 03:23:25 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ~ppc64"
IUSE="doc python"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.2
	python? ( >=dev-python/pygtk-2
		>=dev-lang/python-2.2 )"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS README HACKING INSTALL NEWS TODO ChangeLog"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-spaces.patch
	# Apply the, shift-<up,down> scroll one
	# line at a time patch.
	epatch ${FILESDIR}/${PN}-line-scroll.patch
}
