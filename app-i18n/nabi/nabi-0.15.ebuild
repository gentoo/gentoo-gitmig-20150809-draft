# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nabi/nabi-0.15.ebuild,v 1.3 2006/10/14 09:23:55 flameeyes Exp $

DESCRIPTION="Simple Hanguk X Input Method"
HOMEPAGE="http://nabi.kldp.net/"
SRC_URI="http://download.kldp.net/nabi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND=">=x11-libs/gtk+-2.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS
}

pkg_postinst() {
	einfo "You MUST add environment variable..."
	einfo
	einfo "export XMODIFIERS=\"@im=nabi\""
	einfo
}
