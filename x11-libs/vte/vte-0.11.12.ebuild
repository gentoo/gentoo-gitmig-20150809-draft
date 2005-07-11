# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.11.12.ebuild,v 1.12 2005/07/11 23:11:04 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 mips ppc ppc64 sparc x86"
IUSE="doc python"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.2
	python? ( >=dev-python/pygtk-2.4
		>=dev-lang/python-2.2 )"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS README HACKING INSTALL NEWS TODO ChangeLog"
G2CONF="${G2CONF} $(use_enable python)"

src_unpack() {

	unpack ${A}
	cd ${S}/src
	# Apply the, shift-<up,down> scroll one
	# line at a time patch.
	epatch ${FILESDIR}/${PN}-line-scroll.patch
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.11.11-vtemodule.patch
}
