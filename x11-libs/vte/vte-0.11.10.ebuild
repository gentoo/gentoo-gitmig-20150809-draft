# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.11.10.ebuild,v 1.9 2004/03/17 00:54:40 geoman Exp $

inherit gnome2 flag-o-matic

IUSE="doc python"

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips"
LICENSE="LGPL-2"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.2
	python? ( >=dev-python/pygtk-1.99
		>=dev-lang/python-2.2 )"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"

