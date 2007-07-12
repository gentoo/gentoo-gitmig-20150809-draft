# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.7.2.ebuild,v 1.14 2007/07/12 05:34:47 mr_bones_ Exp $

DESCRIPTION="An ncurses based AOL Instant Messenger"
HOMEPAGE="http://naim.n.ml.org"
SRC_URI="http://shell.n.ml.org/n/naim/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc-macos ~sparc x86"
IUSE="debug"

DEPEND=">=sys-libs/ncurses-5.2
	app-misc/screen"

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
