# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xarchiver/xarchiver-0.4.6.ebuild,v 1.24 2007/06/24 23:54:12 vapier Exp $

inherit xfce44

DESCRIPTION="Archive manager"
HOMEPAGE="http://xarchiver.xfce.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_postinst() {
	elog
	elog "You need external programs for some formats, including"
	elog "arj - app-arch/unarj app-arch/arj"
	elog "zip - app-arch/unzip app-arch/zip"
	elog "rar - app-arch/unrar app-arch/rar"
	elog "7zip - app-arch/p7zip"
	elog "lha - app-arch/lha"
	elog

	xfce44_pkg_postinst
}
