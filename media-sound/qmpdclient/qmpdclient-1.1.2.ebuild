# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-1.1.2.ebuild,v 1.4 2010/01/12 18:39:36 nixnut Exp $

EAPI="2"

inherit qt4

DESCRIPTION="QMPDClient with NBL additions, such as lyrics' display"
HOMEPAGE="http://bitcheese.net/wiki/QMPDClient"
SRC_URI="http://dump.bitcheese.net/files/dedycec/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~sparc ~x86"
IUSE="debug dbus"

DEPEND="x11-libs/qt-gui:4[dbus?,debug?]"
RDEPEND="${DEPEND}"

LANGSNOLONG="cs_CZ de_DE fr_FR it_IT nl_NL nn_NO no_NO ru_RU sv_SE tr_TR uk_UA"
LANGS="zh_CN zh_TW pt_BR "

for X in ${LANGSNOLONG}; do
	IUSE="${IUSE} linguas_${X%_*}"
done

for X in ${LANGS};do
	IUSE="${IUSE} linguas_${X}"
done

S="${WORKDIR}/${PN}"

src_prepare() {
	# Fix the install path
	sed -i -e "s:PREFIX = /usr/local:PREFIX = /usr:" ${PN}.pro \
		|| die "sed failed (install path)"

	# Fix package version
	sed -i -e "s:1.1.1:${PV}:" ${PN}.pro || die "failed to fix package version"
	# nostrip fix
	sed -i -e "s:CONFIG += :CONFIG += nostrip :" ${PN}.pro \
		|| die "sed failed (nostrip)"

	sed -i -e "s:+= -O2 -g0 -s:+= -O2 -g0:" ${PN}.pro \
		|| die "sed failed (nostrip)"

	# fix installation folder name
	sed -i "s/share\/QMPDClient/share\/qmpdclient/" ${PN}.pro src/config.cpp \
		|| die "failed to fix installation directory"

	# check dbus
	if ! use dbus; then
		sed -i -e "s/message(DBus notifier:\ enabled)/message(DBus notifier:\ disabled)/" \
			-e "s/CONFIG\ +=\ nostrip\ qdbus//" \
			-e "s/SOURCES\ +=\ src\/notifications_dbus.cpp/SOURCES\ +=\ src\/notifications_nodbus.cpp/" \
			${PN}.pro || die "disabling dbus failed"
	fi
}

src_configure() {
	eqmake4 qmpdclient.pro
}

src_compile() {
	emake || die "emake failed"
	# generate translations
	emake translate || die "failed to generate translations"
	cd "${S}"/lang
	for X in *.ts;do
		lrelease "${X}" || die "lrelease failed"
	done
}

src_install() {
	emake install INSTALL_ROOT="${D}" || die "emake install failed"
	dodoc README AUTHORS THANKSTO Changelog || die "Installing docs failed"
	for res in 16 22 64 ; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins icons/qmpdclient${res}.png ${PN}.png || die "Installing icons failed"
	done

	#install translations
	insinto /usr/share/${PN}/translations/
	local LANG=
	for LANG in ${LINGUAS};do
	    for X in ${LANGSNOLONG};do
			if [[ ${LANG} == ${X%_*} ]];then
		    	doins -r lang/${X}.qm || die "failed to install translations"
			fi
	    done
		for X in ${LANGS};do
			if [[ ${LANG} == ${X} ]]; then
				doins -r lang/${X}.qm || die "failed to install translations"
			fi
		done
	done
}
