# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/licq/licq-1.3.8.ebuild,v 1.2 2009/12/14 14:23:16 ssuominen Exp $

EAPI=2
CMAKE_USE_DIR="${S}/plugins/qt4-gui"
inherit cmake-utils

DESCRIPTION="ICQ Client with v8 support"
HOMEPAGE="http://www.licq.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="debug linguas_he ncurses msn nls crypt kde socks5 ssl qt4 xosd"

RDEPEND="crypt? ( >=app-crypt/gpgme-1 )
	ncurses? ( sys-libs/ncurses
		dev-libs/cdk )
	ssl? ( >=dev-libs/openssl-0.9.5a )
	qt4? ( x11-libs/qt-gui:4
		kde? ( >=kde-base/kdelibs-4
			!kde-base/kdelibs[kdeprefix] ) )
	xosd? ( x11-libs/xosd )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-libs/boost"

pkg_setup() {
	licq_plugins="auto-reply email rms"
	use ncurses && licq_plugins="${licq_plugins} console"
	use msn && licq_plugins="${licq_plugins} msn"
	use xosd && licq_plugins="${licq_plugins} osd"
}

src_configure() {
	econf \
		$(use_enable linguas_he hebrew) \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable socks5) \
		$(use_enable ssl openssl) \
		$(use_enable nls)

	local x
	for x in ${licq_plugins}; do
		cd "${S}"/plugins/${x}
		econf
	done

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kde)"
	use qt4 && cmake-utils_src_configure
}

src_compile() {
	emake || die

	local x
	for x in ${licq_plugins}; do
		cd "${S}"/plugins/${x}
		emake || die
	done

	use qt4 && cmake-utils_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README

	docinto doc
	dodoc doc/*

	use crypt && dodoc README.GPG
	use ssl && dodoc README.OPENSSL

	exeinto /usr/share/${PN}/upgrade
	doexe upgrade/*.pl || die

	local x
	for x in ${licq_plugins}; do
		cd "${S}"/plugins/${x}
		emake DESTDIR="${D}" install || die
		docinto ${x}
		dodoc README* *.conf
	done

	if use qt4; then
		docinto qt4
		DOCS="README" cmake-utils_src_install
	fi

	rm -rf "${D}"/var
}
