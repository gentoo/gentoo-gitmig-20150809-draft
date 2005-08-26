# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-mist/gtk-engines-mist-0.10-r2.ebuild,v 1.2 2005/08/26 13:52:43 agriffis Exp $

inherit eutils

MY_PN="gtk-mist-engine"
MY_P=${MY_PN}-${PV}

DESCRIPTION="GTK+1 Mist Theme Engine"
HOMEPAGE="http://primates.ximian.com/~dave/mist/"
SRC_URI="http://primates.ximian.com/~dave/mist/${MY_P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="1"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# patch that adds --[enable|disable]-gtk-[1|2] - liquidx@g.o (04 Oct 03)
	epatch ${FILESDIR}/${P}-autoconf.patch

	export WANT_AUTOMAKE=1.6
	aclocal  || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
	libtoolize --copy --force
}

src_compile() {
	local myconf="--enable-gtk-1 --disable-gtk-2 $(use_enable static)"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
