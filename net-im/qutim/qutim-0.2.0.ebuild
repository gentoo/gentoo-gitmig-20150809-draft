# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qutim/qutim-0.2.0.ebuild,v 1.2 2009/11/29 09:39:13 hwoarang Exp $

EAPI="2"

inherit eutils qt4 cmake-utils
MY_PN="${PN/im/IM}"

DESCRIPTION="New Qt4-based Instant Messenger (ICQ)."
HOMEPAGE="http://www.qutim.org"
LICENSE="GPL-2"
SRC_URI="http://qutim.org/uploads/src/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug histman icq irc jabber gnutls mrim ssl vkontakte yandexnarod"

DEPEND="x11-libs/qt-gui:4[debug?]
	x11-libs/qt-webkit:4
	|| ( media-sound/phonon x11-libs/qt-phonon )
	jabber? ( ssl? ( dev-libs/openssl )
		gnutls? ( net-libs/gnutls ) )"
RDEPEND="${DEPEND}"

src_compile() {
	# build main executable
	cmake-utils_src_compile

	# build protocol support
	if use jabber; then
		cd  "${S}"/plugins/jabber || die
		mkdir build
		cd build
		cmake -C "${TMPDIR}"/gentoo_common_config.cmake \
			  $(cmake-utils_use ssl OpenSSL) \
			  $(cmake-utils_use gnutls GNUTLS) ../ || die
		emake || die
	fi
	# build mrim
	if use mrim; then
		cd "${S}"/plugins/mrim || die
		mkdir build
		cd build
		cmake -C "${TMPDIR}"/gentoo_common_config.cmake ../ || die
		emake || die "failed to compile mrim plugin"
	fi
	# Qt4 based projects so I shall use eqmake4
	cd "${S}"/plugins || die
	for i in histman yandexnarod icq irc vkontakte;do
		if use ${i}; then
			cd "${i}"
			einfo "now building ${i}-plugin"
			eqmake4 ${i}.pro
			emake || die "failed to compile ${i} plugin"
			cd ..
		fi
	done
}

src_install(){
	# not recommended by upstream and probably broken
	#cmake-utils_src_install
	dobin "${WORKDIR}/${P}_build/${PN}" || die

	cd "${S}"/plugins || die
	insinto "/usr/$(get_libdir)/qutim"
	doins $(find . -type f -executable -iname "*.so") || die
	doicon "${S}"/icons/${PN}_64.png || die "Failed to install icon"
	make_desktop_entry ${PN} ${MY_PN} ${PN}_64.png \
	"Network;InstantMessaging;Qt" || die "make_desktop_entry failed"
}
