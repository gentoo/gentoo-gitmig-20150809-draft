# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglext/gtkglext-0.7.0.ebuild,v 1.3 2003/03/21 15:03:44 foser Exp $

inherit gnome2

IUSE="doc"

DESCRIPTION="GL extentions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-libs/pango-1
	virtual/glu
	virtual/opengl
	!media-video/nvidia-glx-1.0.4191"
#this specific nvidia-glx ebuild doesn't contain a needed patch

DEPEND="${DEPEND}
	doc? ( >=dev-util/gtk-doc-0.10 )"

S=${WORKDIR}/${P}

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS* README* TODO"
