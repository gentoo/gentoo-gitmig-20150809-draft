# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lavaps/lavaps-2.7-r1.ebuild,v 1.1 2005/06/23 20:45:32 smithj Exp $

inherit eutils

DESCRIPTION="Lava Lamp graphical representation of running processes."
SRC_URI="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/${P}.tar.gz"
HOMEPAGE="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="gtk"

DEPEND=">=dev-lang/tk-8.3.3
	virtual/x11
	gtk? ( x11-libs/gtk+ )
	!gtk? ( dev-lang/tcl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-this-makes-it-compile.patch
}

src_compile() {
	local myconf="--with-x"
	use gtk && myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --with-tcltk"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	doman lavaps.1
	dodoc COPYING README
	dohtml doc/*.html
}
