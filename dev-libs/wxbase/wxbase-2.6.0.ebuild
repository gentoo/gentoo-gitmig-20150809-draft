# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wxbase/wxbase-2.6.0.ebuild,v 1.1 2005/05/02 18:07:19 pythonhead Exp $

inherit wxlib

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"

SLOT="2.6"
KEYWORDS="~x86 ~amd64"

src_compile() {
	configure_build base unicode "--disable-gui"
}

src_install() {
	install_build base

	wxlib_src_install
}
