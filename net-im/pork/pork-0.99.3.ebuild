# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pork/pork-0.99.3.ebuild,v 1.1 2004/07/19 17:23:52 lostlogic Exp $

DESCRIPTION="Console based AIM client that looks like ircII"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc"
IUSE="perl"

DEPEND="perl? ( dev-lang/perl )
	sys-libs/ncurses"

src_compile() {
	local myconf=""
	use perl || myconf="${myconf} --disable-perl"
	einfo "Configure options: ${myconf}"
	econf ${myconf} || die "econf failed"
	emake
}

src_install() {
	einstall

	doman doc/pork.1
	insinto /usr/share/pork/examples
	doins examples/blist.txt

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README STYLE TODO QUICK_START
}
