# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.10.29.ebuild,v 1.3 2003/07/01 22:11:38 gmsoft Exp $

inherit gnome2 flag-o-matic

# -Os takes us down (#16173)
replace-flags "-Os" "-O2"

IUSE="doc python"

DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"
LICENSE="LGPL-2"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.2"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	python? ( >=dev-python/pygtk-1.99
		>=dev-lang/python-2.2 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"

use python \
	&& G2CONF="${G2CONF} --enable-python" \
	|| G2CONF="${G2CONF} --disable-python"
