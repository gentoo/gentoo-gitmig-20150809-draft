# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.11.10-r1.ebuild,v 1.6 2004/09/03 15:35:20 pvdabeel Exp $

inherit eutils flag-o-matic gnome2

IUSE="doc python"

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~hppa amd64 ~ia64 ~mips"
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

src_unpack() {
	unpack ${A}
	cd ${S}

	# Avoid inefficiencies when the background is a small pixmap, as
	# is the case when the background of a Gnome desktop is set to "No
	# Picture" and "Solid Color". See bug #31830.
	epatch ${FILESDIR}/${P}-bg_fix.patch
}
