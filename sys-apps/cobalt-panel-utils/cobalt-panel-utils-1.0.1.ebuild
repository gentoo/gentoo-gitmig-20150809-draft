# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cobalt-panel-utils/cobalt-panel-utils-1.0.1.ebuild,v 1.2 2008/10/14 02:03:19 darkside Exp $

inherit eutils

DESCRIPTION="LCD and LED panel utilities for the Sun Cobalts"
HOMEPAGE="http://gentoo.404ster.com/"
SRC_URI="ftp://www.404ster.com/pub/gentoo-stuff/ebuilds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="sys-devel/gettext"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_compile() {
	emake || die
}

src_install() {
	into /
	dosbin	"${S}"/lcd-flash "${S}"/lcd-getip "${S}"/lcd-swrite \
	"${S}"/lcd-write "${S}"/lcd-yesno "${S}"/lcd-setcursor "${S}"/iflink \
	"${S}"/iflinkstatus "${S}"/readbutton || die "dosbin failed"

	dodoc doc/README* doc/CREDITS
	doman doc/man/*.1
}
