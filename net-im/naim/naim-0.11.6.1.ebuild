# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.6.1.ebuild,v 1.5 2004/01/15 05:39:11 avenj Exp $


DESCRIPTION="An ncurses based AOL Instant Messenger"
HOMEPAGE="http://naim.n.ml.org"
SRC_URI="http://shell.n.ml.org/n/naim/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips ~alpha ~arm ~hppa ia64 amd64"
IUSE="debug"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	local myconf=""
	# --enable-profile
	# --experimental-buddy-grouping
	use debug && myconf="--enable-debug"

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
