# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/uevt/uevt-2.1_p20110313.ebuild,v 1.1 2011/03/13 13:36:26 ssuominen Exp $

EAPI=3
inherit autotools

DESCRIPTION="A lightweight, desktop-independant daemon for disks mounting and power managing"
HOMEPAGE="http://elentir.sleipnir.fr/ http://git.sleipnir.fr/uevt/"
#SRC_URI="http://ftp.sleipnir.fr/${PN}/${P}.tar.bz2"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/glib-2.26
	x11-libs/gtk+:2
	>=x11-libs/libnotify-0.7"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks
	sys-power/upower"
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	dev-lang/vala:0.12
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	eautoreconf
}

src_configure() {
	export VALAC="$(type -P valac-0.12)"
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
