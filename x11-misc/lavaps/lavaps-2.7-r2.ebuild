# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lavaps/lavaps-2.7-r2.ebuild,v 1.5 2009/05/05 17:43:28 ssuominen Exp $

inherit autotools eutils

DESCRIPTION="Lava Lamp graphical representation of running processes."
HOMEPAGE="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/"
SRC_URI="http://www.isi.edu/~johnh/SOFTWARE/LAVAPS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="gtk"

RDEPEND=">=dev-lang/tk-8.3.3
	gtk? ( >=x11-libs/gtk+-2.2
		>=gnome-base/libgnomecanvas-2.2
		>=gnome-base/libgnomeui-2.2 )
	!gtk? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/intltool )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-this-makes-it-compile.patch"
	epatch "${FILESDIR}/${P}-build-fixes.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
	#We need to get rid of the old macros.
	rm acinclude.m4
	#Update to newer namespace.
	sed -i \
		-e "s:AC_PROG_INTLTOOL:IT_PROG_INTLTOOL:" \
		-e "s:AM_GLIB_GNU_GETTEXT:GLIB_GNU_GETTEXT:" \
		configure.gtk.ac
	eautoreconf
}

src_compile() {
	local myconf="--with-x"
	use gtk && myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --with-tcltk"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README
	doman doc/lavaps.1
	dohtml doc/*.html
}
