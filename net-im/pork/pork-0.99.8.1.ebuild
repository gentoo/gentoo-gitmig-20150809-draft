# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pork/pork-0.99.8.1.ebuild,v 1.6 2005/07/18 19:01:29 smithj Exp $

DESCRIPTION="Console based AIM client that looks like ircII"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~ppc-macos sparc x86"
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

pkg_postinst() {
	einfo "Be aware that the syntax for IRC connections has"
	einfo "changed. Read ${HOMEPAGE}/stuff/pork.news"
	einfo "for details."
}

