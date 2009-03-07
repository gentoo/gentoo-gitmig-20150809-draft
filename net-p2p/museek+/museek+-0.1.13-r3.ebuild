# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/museek+/museek+-0.1.13-r3.ebuild,v 1.3 2009/03/07 15:22:26 betelgeuse Exp $

EAPI=2

inherit qt3 eutils distutils multilib

DESCRIPTION="A SoulSeek client which uses a daemon and multiple gui clients."
HOMEPAGE="http://www.museek-plus.org"
SRC_URI="mirror://sourceforge/museek-plus/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fam gtk ncurses qsa qt3 trayicon vorbis"

RDEPEND=">=dev-cpp/libxmlpp-1.0.2
	dev-lang/python[ncurses?]
	gtk? ( >=dev-python/pygtk-2.6.1 )
	qt3? ( x11-libs/qt:3 )
	qsa? ( >=dev-libs/qsa-1.1.1 )
	vorbis? ( media-libs/libvorbis
		media-libs/libogg )
	fam? ( virtual/fam )"
DEPEND="${RDEPEND}
		dev-lang/swig
		>=dev-util/cmake-2.4.6"

src_prepare() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-optional-deps.patch"
	epatch "${FILESDIR}/${P}-post_release_fixes.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
	sed -i -e "s:join('lib':join('$(get_libdir)':g" \
		*/CMakeLists.txt || die "sed failed"
}

my_use() {
	use $1 && echo "1" || echo "0"
}

src_configure() {
	# Build museekd, mucous, murmur, python bindings and clients
	local myconf="-DPREFIX=/usr -DMANDIR=share/man -DBINDINGS=1 -DCLIENTS=1"
	myconf="${myconf} -DSWIG_DIR='$(swig -swiglib)'" # bug #192594
	myconf="${myconf} -DMUCOUS=$(my_use ncurses)
		-DMURMUR=$(my_use gtk)
		-DNO_MUSEEQ=$(my_use !qt3)
		-DTRAYICON=$(my_use trayicon)
		-DQSA=$(my_use qsa)
		-DNO_MUSCAND=$(my_use !fam)
		-DVORBIS=$(my_use vorbis)"
	if ! use debug ; then
		myconf="${myconf} -DMULOG=none"
	fi

	cmake ${myconf} || die "cmake failed"
}

src_compile() {
	emake || die "emake failed"

	# Build setup tools
	cd "${S}/setup"
	distutils_src_compile
}

src_install() {
	# Install main stuff
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README CREDITS CHANGELOG TODO || die

	# Install setup tools
	cd "${S}/setup"
	distutils_src_install

	# fix wrong path to make musetup-gtk working, #193444, #210364
	dodir /usr/share/museek/museekd
	mv "${D}"/usr/share/{,museek/museekd/}config.xml.tmpl
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "Some tools require you to install extra software to run:"
	elog "musetup-gtk: dev-python/pygtk"
	elog "musetup-qt: dev-python/PyQt"
	elog
	elog "In order to configure ${PN} execute musetup, musetup-gtk,"
	elog "or musetup-qt with your user."
	elog "Then you can launch ${PN} daemon with 'museekd' and use"
	elog "any of the provided clients."
}
