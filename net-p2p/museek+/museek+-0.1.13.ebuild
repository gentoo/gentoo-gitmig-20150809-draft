# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/museek+/museek+-0.1.13.ebuild,v 1.1 2007/09/22 19:26:08 coldwind Exp $

inherit qt3 eutils distutils multilib

DESCRIPTION="A SoulSeek client which uses a daemon and multiple gui clients."
HOMEPAGE="http://www.museek-plus.org"
SRC_URI="mirror://sourceforge/museek-plus/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug gtk ncurses qt3 trayicon"

RDEPEND=">=dev-cpp/libxmlpp-1.0.2
		gtk? ( >=dev-python/pygtk-2.6.1 )
		qt3? ( $(qt_min_version 3.3)
			>=dev-libs/qsa-1.1.1 )
		media-libs/libvorbis
		media-libs/libogg
		virtual/fam"
DEPEND="${RDEPEND}
		dev-lang/swig"

pkg_setup() {
	if use ncurses && ! built_with_use dev-lang/python ncurses ; then
		eerror "In order to build Mucous (museek ncurses client)"
		eerror "you need dev-lang/python built with ncurses USE flag enabled."
		die "no ncurses support in Python"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-post_release_fixes.patch"
	sed -i -e "s:join('lib':join('$(get_libdir)':g" \
		*/CMakeLists.txt || die "sed failed"
}

src_compile() {
	# Build museekd, mucous, murmur, python bindings and clients
	local myconf="-DPREFIX=/usr -DMANDIR=share/man -DBINDINGS=1 -DCLIENTS=1"
	myconf="${myconf} -DSWIG_DIR='$(swig -swiglib)'" # bug #192594
	if use ncurses ; then
		myconf="${myconf} -DMUCOUS=1"
	else
		myconf="${myconf} -DMUCOUS=0"
	fi
	if use gtk ; then
		myconf="${myconf} -DMURMUR=1"
	else
		myconf="${myconf} -DMURMUR=0"
	fi
	if use qt3 ; then
		myconf="${myconf} -DNO_MUSEEQ=0"
		use trayicon && myconf="${myconf} -DTRAYICON=1"
	else
		myconf="${myconf} -DNO_MUSEEQ=1"
	fi
	if ! use debug ; then
		myconf="${myconf} -DMULOG=none"
	fi

	cmake ${myconf} || die "cmake failed"
	emake || die "emake failed"

	# Build setup tools
	cd "${S}/setup"
	distutils_src_compile
}

src_install() {
	# Install main stuff
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README CREDITS CHANGELOG TODO

	# Install setup tools
	cd "${S}/setup"
	distutils_src_install
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "In order to configure ${PN} execute musetup, musetup-gtk,"
	elog "or musetup-qt with your user."
	elog "Then you can launch ${PN} daemon with 'museekd' and use"
	elog "any of the provided clients."
}
