# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcaca/libcaca-0.99_beta11.ebuild,v 1.10 2007/03/27 15:21:55 armin76 Exp $

inherit eutils autotools libtool

MY_P="${P/_beta/.beta}"

DESCRIPTION="A library that creates colored ASCII-art graphics"
HOMEPAGE="http://libcaca.zoy.org/"
SRC_URI="http://libcaca.zoy.org/files/${MY_P}.tar.gz"

LICENSE="WTFPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="ncurses slang doc imlib X opengl nocxx"

RDEPEND="ncurses? ( >=sys-libs/ncurses-5.3 )
	slang? ( =sys-libs/slang-1.4* )
	imlib? ( media-libs/imlib2 )
	X? ( x11-libs/libX11 x11-libs/libXt )
	opengl? ( virtual/opengl virtual/glut )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-0.99_beta4-deoptimise.patch"

	eautoreconf
	elibtoolize
}

src_compile() {
	# temp font fix #44128
	export VARTEXFONTS="${T}/fonts"

	econf \
		$(use_enable doc) \
		$(use_enable ncurses) \
		$(use_enable slang) \
		$(use_enable imlib imlib2) \
		$(use_enable X x11) $(use_with X x) --x-libraries=/usr/$(get_libdir) \
		$(use_enable opengl) \
		$(use_enable !nocxx cxx) \
		|| die "econf failed"
	emake || die "emake failed"
	unset VARTEXFONTS
}

src_install() {
	mv doc/man/man3caca doc/man/man3
	emake -j1 install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS NOTES README TODO
}
