# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-quicklauncher/xfce4-quicklauncher-1.9.4.ebuild,v 1.10 2007/10/26 13:48:31 angelos Exp $

inherit autotools xfce44

xfce44
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 panel quicklauncher plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^AC_INIT/s/quicklauncher_version()/quicklauncher_version/" configure.ac
	eautoconf
}

DOCS="AUTHORS NEWS README TODO"
