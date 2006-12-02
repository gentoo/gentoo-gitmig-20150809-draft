# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wispy-tools/wispy-tools-2006.03.1.ebuild,v 1.4 2006/12/02 23:53:42 beandog Exp $

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Tools for the MetaGeek Wi-Spy spectrum analyzer"
HOMEPAGE="http://www.kismetwireless.net/wispy.shtml"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug gtk ncurses"

DEPEND="dev-libs/libusb
		ncurses? ( sys-libs/ncurses )
		gtk? ( || ( =x11-libs/gtk+-1.2* =x11-libs/gtk+-2* ) )"

src_compile() {
	econf || die "econf failed"

	emake wispy_log || die "emake wispy_log failed"

	if use debug; then
		emake wispy_raw || die "emake wispy_raw failed"
	fi

	if use ncurses; then
		emake wispy_curses || die "emake wispy_curses failed"
	fi

	if use gtk; then
		emake wispy_gtk || die "emake wispy_gtk failed"
	fi
}

src_install() {
	dobin wispy_log
	use debug && dobin wispy_raw
	use ncurses && dobin wispy_curses
	use gtk && dobin wispy_gtk

	dodoc README
}
