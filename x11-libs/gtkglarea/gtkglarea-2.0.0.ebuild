# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-2.0.0.ebuild,v 1.2 2009/05/05 07:40:36 ssuominen Exp $

inherit gnome2 multilib autotools

DESCRIPTION="GL extensions for gtk+"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.3
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README* docs/*.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_install() {
	gnome2_src_install
}
