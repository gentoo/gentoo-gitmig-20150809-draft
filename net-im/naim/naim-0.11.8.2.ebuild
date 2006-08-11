# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.8.2.ebuild,v 1.3 2006/08/11 23:03:16 weeve Exp $


DESCRIPTION="An ncurses based AOL Instant Messenger"
HOMEPAGE="http://naim.n.ml.org"
SRC_URI="http://shell.n.ml.org/n/naim/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="debug screen"

DEPEND=">=sys-libs/ncurses-5.2
		screen? ( app-misc/screen )"

src_unpack() {
	unpack ${A}

	# Alter makefile so firetalk-int.h is installed
	cd ${S}
	sed -i 's/include_HEADERS = firetalk.h/include_HEADERS = firetalk.h firetalk-int.h/' \
		libfiretalk/Makefile.am \
		libfiretalk/Makefile.in
}

src_compile() {
	# --enable-profile
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"
	use screen && myconf="${myconf} --enable-detach"

	econf \
		--with-pkgdocdir=/usr/share/doc/${PF} \
		${myconf} \
		|| die "configure failed"

	# Use make instead of emake, because naim doesn't compile with ${MAKEOPTS} > 1
	# see bug #139329
	make || die "make failed"
}

src_install() {
	cd ${S}
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS FAQ BUGS README NEWS ChangeLog doc/*.hlp
}
