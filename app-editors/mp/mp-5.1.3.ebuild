# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-5.1.3.ebuild,v 1.2 2010/07/29 17:46:39 flameeyes Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Minimum Profit: A text editor for programmers"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://www.triptico.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="gtk iconv kde ncurses nls pcre qt4"

RDEPEND="
	ncurses? ( sys-libs/ncurses )
	gtk? ( >=x11-libs/gtk+-2 >=x11-libs/pango-1.8.0 )
	!gtk? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	pcre? ( dev-libs/libpcre )
	iconv? ( virtual/libiconv )
	app-text/grutatxt"
DEPEND="${RDEPEND}
	app-text/grutatxt
	dev-util/pkgconfig
	dev-lang/perl"

src_prepare() {
	# fix force as-needed wrt bug #278086
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_configure() {
	local myconf="--prefix=${EPREFIX}/usr --without-win32"

	if use gtk; then
		! use ncurses && myconf="${myconf} --without-curses"
	else
		myconf="${myconf} --without-gtk2"
	fi

	use iconv || myconf="${myconf} --without-iconv"

	use kde || myconf="${myconf} --without-kde4"

	use nls || myconfig="${myconf} --without-gettext"

	myconf="${myconf} $(use_with pcre)"
	use pcre || myconf="${myconf} --with-included-regex"

	use qt4 || myconf="${myconf} --without-qt4"

	for i in "${S}" "${S}"/mpsl "${S}"/mpdm;do
		echo ${CFLAGS} >> $i/config.cflags
		echo ${LDFLAGS} >> $i/config.ldflags
	done

	tc-export CC
	sh config.sh ${myconf} || die "Configure failed"
}

src_compile() {
	# bug #326987
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/bin
	sh config.sh --prefix="${EPREFIX}/usr"
	emake -j1 DESTDIR="${D}" install || die "Install Failed"
#	use gtk && dosym mp-5 /usr/bin/gmp
}

pkg_postinst() {
	if use gtk ; then
		einfo
		einfo "mp-5 is symlinked to gmp! Use"
		einfo "$ DISPLAY=\"\" mp-5"
		einfo "to use text mode!"
		einfo
	fi
}
