# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcaca/libcaca-0.9-r1.ebuild,v 1.5 2004/11/08 15:17:34 vapier Exp $

inherit eutils

DESCRIPTION="A library that creates colored ASCII-art graphics"
HOMEPAGE="http://sam.zoy.org/projects/libcaca"
SRC_URI="http://sam.zoy.org/projects/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="ncurses slang doc imlib X"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.3 )
	slang? ( >=sys-libs/slang-1.4.2 )
	doc? ( app-doc/doxygen )
	imlib? ( media-libs/imlib2 )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	# Let libtool build the libraries, see BUG #57359
	epatch ${FILESDIR}/${P}-libtool.patch
	cd "${S}"
	libtoolize --force || die "libtoolize"
	aclocal || die "aclocal"
	automake --add-missing || die "automake"
	autoconf || die "autoconf"
}

src_compile() {
	# temp font fix #44128
	export VARTEXFONTS="${T}/fonts"
	econf \
	    $(use_enable doc) \
	    $(use_enable ncurses) \
	    $(use_enable slang) \
	    $(use_enable imlib imlib2) \
		$(use_enable X x11) \
	    || die
	emake || die
	unset VARTEXFONTS
}

src_install() {
	mv doc/man/man3caca doc/man/man3
	make install DESTDIR="${D}" || die
	dodoc AUTHORS BUGS ChangeLog NEWS NOTES README TODO
}
