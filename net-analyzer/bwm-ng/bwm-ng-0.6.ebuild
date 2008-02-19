# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwm-ng/bwm-ng-0.6.ebuild,v 1.5 2008/02/19 22:50:19 opfer Exp $

DESCRIPTION="Bandwidth Monitor NG is a small and simple console-based bandwidth monitor"
SRC_URI="http://www.gropp.org/bwm-ng/${P}.tar.gz"
HOMEPAGE="http://www.gropp.org/"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="html csv"

DEPEND=">=sys-libs/ncurses-5.4-r4
	>=sys-apps/net-tools-1.60-r1"

src_compile() {
	econf \
		--with-ncurses \
		$(use_enable html) \
		$(use_enable csv) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
}
