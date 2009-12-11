# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/licq/licq-1.3.6.ebuild,v 1.11 2009/12/11 15:11:08 ssuominen Exp $

EAPI="1"

CMAKE_USE_DIR="${S}/plugins/qt4-gui"
inherit eutils kde-functions multilib cmake-utils

DESCRIPTION="ICQ Client with v8 support"
HOMEPAGE="http://www.licq.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="crypt debug kde msn ncurses nls qt3 qt4 socks5 ssl xosd"

# we use kde as KDE4
RDEPEND="kde? (
		qt3? ( kde-base/kdelibs:3.5 )
	)
	ssl? ( dev-libs/openssl )
	qt3? ( x11-libs/qt:3 )
	qt4? ( x11-libs/qt-gui:4 )
	nls? ( sys-devel/gettext )
	ncurses? ( sys-libs/ncurses dev-libs/cdk )
	crypt? ( app-crypt/gpgme:1 )
	xosd? ( x11-libs/xosd )"
DEPEND="${RDEPEND}
	dev-libs/boost"

PATCHES=( "${FILESDIR}/${P}-glibc-2.10.patch" )

_generate_plugins_directories() {
	PLUGINS="auto-reply email rms"
	use msn && PLUGINS="${PLUGINS} msn"
	use ncurses && PLUGINS="${PLUGINS} console"
	use xosd &&  PLUGINS="${PLUGINS} osd"
	# QT4 is something extra. Uses cmake.
	use qt4 && PLUGINS_CMAKE="${PLUGINS_CMAKE} qt4-gui"
	use qt3 && PLUGINS="${PLUGINS} qt-gui"
	elog "I will generate these plugins/frontends for licq:"
	elog "${PLUGINS} ${PLUGINS_CMAKE}"
}

pkg_setup() {
	_generate_plugins_directories
}

src_compile() {
	local myconf myconf2 plugin
	# global config setup for automake
	myconf="$(use_enable crypt gpgme)
		$(use_enable ssl openssl)
		$(use_enable socks5)
		$(use_enable debug)
		$(use_enable nls)"

	einfo "Compiling Licq core."
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"

	for plugin in ${PLUGINS}; do
		cd "${S}"/plugins/"${plugin}"
		einfo "Compiling Licq: \"${plugin}\"."
		if use qt3; then
			set-qtdir 3
			set-kdedir 3
			use kde && myconf2="${myconf} --with-kde"
			myconf2="${myconf2} --with-qt-libraries=${QTDIR}/$(get_libdir)"
		fi
		econf ${myconf} ${myconf2} || die "econf failed"
		emake || die "emake failed"
	done
	# we like qt4 it uses cmake
	if use qt4; then
		einfo "Compiling Licq: \"qt4-gui\"."
		# Possible error because of one tiny issue we introduce in kde
		# it is called kdeprefix and in that case you can't be sure where it
		# find kde stuff. This is working only for -kdeprefix so someone will
		# need to fix this later
		# kde not yet workie
		# use kde && myconf2="${myconf2} -DWITH_KDE=1"
		use kde && ewarn "Sorry but kde4 support is duped and not working so not
		enabling for now"
		cmake-utils_src_compile
	fi
}

src_install() {
	# install core
	einfo "Installing Licq core."
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README* doc/*
	# Install the plug-ins
	for plugin in ${PLUGINS}; do
		cd "${S}"/plugins/"${plugin}"
		einfo "Installing Licq: \"${plugin}\"."
		emake DESTDIR="${D}" install || die "emake install failed"
		dodoc README* *.conf
	done
	if use qt4; then
		einfo "Installing Licq: \"qt4-gui\"."
		cmake-utils_src_install
		docinto plugins/qt4-gui
	fi

	exeinto /usr/share/${PN}/upgrade
	doexe "${S}"/upgrade/*

	# fixes bug #22136 and #149464
	rm -fR "${D}"/var
}
