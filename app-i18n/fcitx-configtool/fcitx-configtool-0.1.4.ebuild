# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-configtool/fcitx-configtool-0.1.4.ebuild,v 1.2 2010/12/18 08:50:55 qiaomuf Exp $

EAPI="2"
DESCRIPTION="A gtk GUI to edit fcitx settings"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	=app-i18n/fcitx-4.0.0
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_install(){
	emake DESTDIR="${D}" install
}
