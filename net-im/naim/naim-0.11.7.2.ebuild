# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.7.2.ebuild,v 1.9 2004/11/01 00:36:00 kloeri Exp $


DESCRIPTION="An ncurses based AOL Instant Messenger"
HOMEPAGE="http://naim.n.ml.org"
SRC_URI="http://shell.n.ml.org/n/naim/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~ppc-macos hppa ~sparc ~amd64 ~alpha"
IUSE="debug"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	# --enable-profile
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf \
		--with-pkgdocdir=/usr/share/doc/${PF} \
		--enable-detach \
		${myconf} \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS FAQ BUGS README NEWS ChangeLog doc/*.hlp
}
