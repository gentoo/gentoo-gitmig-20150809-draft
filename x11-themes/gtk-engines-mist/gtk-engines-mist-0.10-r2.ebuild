# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-mist/gtk-engines-mist-0.10-r2.ebuild,v 1.10 2006/12/28 19:25:55 compnerd Exp $

WANT_AUTOMAKE="1.6"
WANT_AUTOCONF="latest"

inherit autotools eutils

MY_PN="gtk-mist-engine"
MY_P=${MY_PN}-${PV}

DESCRIPTION="GTK+1 Mist Theme Engine"
HOMEPAGE="http://primates.ximian.com/~dave/mist/"
SRC_URI="http://primates.ximian.com/~dave/mist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# patch that adds --[enable|disable]-gtk-[1|2] - liquidx@g.o (04 Oct 03)
	epatch ${FILESDIR}/${P}-autoconf.patch
	eautoreconf
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
