# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kazehakase/kazehakase-0.1.2.ebuild,v 1.1 2004/02/19 09:13:20 brad Exp $

IUSE=""

DESCRIPTION="Kazehakase is a browser with gecko engine like Epiphany or Galeon."
HOMEPAGE="http://kazehakase.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/7934/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"
LICENSE="GPL-2"

DEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool
	net-www/mozilla
	x11-libs/pango
	>=x11-libs/gtk+-2*
	dev-util/pkgconfig"

S="${WORKDIR}/${P}"

pkg_setup(){
	if grep -v gtk2 /var/db/pkg/net-www/mozilla-[[:digit:]]*/USE > /dev/null
	then
		echo
		eerror
		eerror "This needs mozilla used gtk2."
		eerror "To build mozilla use gtk2, please type following command:"
		eerror
		eerror "    # USE=\"gtk2\" emerge mozilla"
		eerror
		die
	fi
}

src_compile(){
	export WANT_AUTOCONF=2.5

	./autogen.sh || die
	econf || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog NEWS README* TODO.ja
}
