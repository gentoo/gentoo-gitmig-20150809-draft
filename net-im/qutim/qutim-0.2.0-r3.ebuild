# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qutim/qutim-0.2.0-r3.ebuild,v 1.6 2011/03/26 16:11:54 dilfridge Exp $

EAPI="2"
LANGSLONG="bg_BG cs_CZ de_DE uk_UA"
LANGS="ru"

inherit eutils qt4-r2 cmake-utils
MY_PN="${PN/im/IM}"

DESCRIPTION="New Qt4-based Instant Messenger (ICQ)."
HOMEPAGE="http://www.qutim.org"
LICENSE="GPL-2"
SRC_URI="http://qutim.org/uploads/src/${P}.tar.bz2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug histman icq irc jabber gnutls mrim ssl vkontakte yandexnarod"

DEPEND="x11-libs/qt-gui:4[debug?]
	x11-libs/qt-webkit:4
	|| ( media-libs/phonon x11-libs/qt-phonon )
	jabber? ( ssl? ( dev-libs/openssl )
		gnutls? ( net-libs/gnutls ) )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/fix_insecure_rpath.patch
)

src_prepare() {
	qt4-r2_src_prepare
	# fix translations directory
	einfo "Fixing LINGUAS path"
	sed -i "s/languages/\/usr\/share\/${PN}\/languages/" src/${PN}.cpp
}

src_compile() {
	# build main executable
	cmake-utils_src_compile
	found=0
	# build protocol support
	if use jabber; then
		found=1
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
		found=1
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
			found=1
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
	[[ $found -eq 1 ]] && doins $(find . -type f -executable -iname "*.so")
	doicon "${S}"/icons/${PN}_64.png || die "Failed to install icon"
	make_desktop_entry ${PN} ${MY_PN} ${PN}_64 \
	"Network;InstantMessaging;Qt" || die "make_desktop_entry failed"

	#install linguas
	for X in ${LANGSLONG}; do
		for Z in ${LINGUAS}; do
			if [[ ${X%_*} == ${Z} ]]; then
				einfo "Installing ${Z} translation files"
				insinto /usr/share/${PN}/languages/${X}/
				doins -r "${S}"/languages/${X}/binaries/* || die "failed to install ${X} translation"
			fi
		done
	done
	for X in ${LANGS}; do
		for Z in ${LINGUAS}; do
			if [[ ${X} == ${Z} ]]; then
				einfo "Installing ${Z} translation files"
				insinto /usr/share/${PN}/languages/${X}/
				doins -r "${S}"/languages/${X}/binaries/* || die "failed to install ${X} translation"
			fi
		done
	done

}
