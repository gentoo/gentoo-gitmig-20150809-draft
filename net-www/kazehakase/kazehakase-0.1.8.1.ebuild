# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kazehakase/kazehakase-0.1.8.1.ebuild,v 1.1 2004/07/29 23:53:00 nakano Exp $

inherit eutils

IUSE="migemo estraier"

DESCRIPTION="Kazehakase is a browser with gecko engine like Epiphany or Galeon."
HOMEPAGE="http://kazehakase.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/10618/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool
	net-www/mozilla
	x11-libs/pango
	>=x11-libs/gtk+-2*
	dev-util/pkgconfig
	migemo? ( app-text/migemo dev-ruby/uconv )
	estraier? ( app-text/estraier )"

RDEPEND="net-www/mozilla
	x11-libs/pango
	>=x11-libs/gtk+-2*
	migemo? ( app-text/migemo dev-ruby/uconv )
	estraier? ( app-text/estraier )"

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
	econf `use_enable migemo` || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog NEWS README* TODO.ja
}
