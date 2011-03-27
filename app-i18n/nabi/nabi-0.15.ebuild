# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nabi/nabi-0.15.ebuild,v 1.8 2011/03/27 10:54:45 nirbheek Exp $

EAPI="1"

DESCRIPTION="Simple Hanguk X Input Method"
HOMEPAGE="http://nabi.kldp.net/"
SRC_URI="http://download.kldp.net/nabi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ppc x86"

RDEPEND=">=x11-libs/gtk+-2.2:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS
}

pkg_postinst() {
	elog "You MUST add environment variable..."
	elog
	elog "export XMODIFIERS=\"@im=nabi\""
	elog
}
