# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxde-common/lxde-common-0.5.0-r2.ebuild,v 1.1 2011/05/18 10:11:51 hwoarang Exp $

EAPI="1"

inherit eutils

DESCRIPTION="LXDE Session default configuration files and nuoveXT2 iconset"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"
PDEPEND="lxde-base/lxde-icon-theme"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-session-fix.patch
	epatch "${FILESDIR}"/${P}-desktop-icons.patch
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}

pkg_postinst() {
	elog "${P} has renamed the configuration file name to"
	elog "/etc/xdg/lxsession/LXDE/desktop.conf"
	elog "Keep in mind you have to migrate your custom settings"
	elog "from /etc/xdg/lxsession/LXDE/config"
}
