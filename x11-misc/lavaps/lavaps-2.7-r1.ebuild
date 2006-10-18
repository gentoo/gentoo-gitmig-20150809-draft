# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lavaps/lavaps-2.7-r1.ebuild,v 1.7 2006/10/18 00:18:20 omp Exp $

inherit eutils

DESCRIPTION="Lava Lamp graphical representation of running processes."
HOMEPAGE="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/"
SRC_URI="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="gtk"

DEPEND=">=dev-lang/tk-8.3.3
	gtk? ( >=x11-libs/gtk+-2.2
		>=gnome-base/libgnomecanvas-2.2
		>=gnome-base/libgnomeui-2.2 )
	!gtk? ( dev-lang/tcl )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-this-makes-it-compile.patch"
}

src_compile() {
	local myconf="--with-x"
	use gtk && myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --with-tcltk"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doman lavaps.1
	dodoc README
	dohtml doc/*.html
}
