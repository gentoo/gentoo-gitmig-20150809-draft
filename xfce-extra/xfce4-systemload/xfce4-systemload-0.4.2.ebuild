# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systemload/xfce4-systemload-0.4.2.ebuild,v 1.14 2007/10/24 01:38:48 angelos Exp $

inherit autotools xfce44

xfce44

DESCRIPTION="System load monitor panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^AC_INIT/s/systemload_version()/systemload_version/" configure.in
	eautoconf
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
