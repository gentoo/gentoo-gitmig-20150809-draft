# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ifpgui/ifpgui-0.10.8.ebuild,v 1.4 2007/12/07 14:00:28 coldwind Exp $

inherit eutils qt3

DESCRIPTION="A Linux GUI for the iRiver iFP flash portable player based on QT"
HOMEPAGE="http://ifpgui.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"
LANGS="da de ru"
for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

RDEPEND=">=media-libs/libifp-1.0.0.2
	$(qt_min_version 3.3)
	>=dev-libs/libusb-0.1.7"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.3.7 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# some Doxyfile improvements
	if use doc; then
		epatch "${FILESDIR}"/${PN}-doxyfile_fixes.patch
		sed -i -e '/PROJECT_NUMBER/ s/[0..9].*$/'${PV}'/' \
			-e '/OUTPUT/ s/\/home.*$/\.\/doc/' Doxyfile
		mkdir doc
	fi

	# we want to use system libifp
	rm -rf src/libifp src/ifp.h
	epatch "${FILESDIR}"/${PN}-use_system_libifp.patch

	# change path to translation files
	epatch "${FILESDIR}"/${PN}-translation_files_directory.patch

	# fixing locale
	mv src/translations/${PN}_da_DK.ts src/translations/${PN}_da.ts
}

src_compile() {
	cd src
	${QTDIR}/bin/qmake src.pro \
		QMAKE=${QTDIR}/bin/qmake \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_RPATH= \
		"CONFIG += no_fixpath release thread" \
		|| die "qmake src.pro failed"
	cd "${S}"

	${QTDIR}/bin/qmake ${PN}.pro \
		QMAKE=${QTDIR}/bin/qmake \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_RPATH= \
		"CONFIG += no_fixpath release thread" \
		|| die "qmake ${PN}.pro failed"

	emake || die "emake failed"

	use doc && doxygen

	# make translation files if there are any chosen
	cd src/translations
	for i in ${LANGS}; do
		use linguas_${i} && [ -f ${PN}_${i}.ts ] && ${QTDIR}/bin/lrelease ${PN}_${i}.ts
	done;
}

src_install() {
	dobin bin/${PN}

	insinto /usr/share/${PN}
	doins nonroot.sh

	dodoc README CHANGELOG
	if use doc; then
		cp -ar doc/* "${D}"/usr/share/doc/${PF}
	fi;

	# install translation files
	cd src/translations
	insinto /usr/share/${PN}/i18n
	for i in ${LANGS}; do
		use linguas_${i} && [ -f ${PN}_${i}.qm ] && doins ${PN}_${i}.qm
	done;
	cd "${S}"

	# desktop file and icon
	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png
}

pkg_postinst() {
	echo
	ewarn "If you want to use ifpgui without root-privileges, you can run"
	ewarn "emerge --config =${CATEGORY}/${PF}"
	ewarn "or manually use the script"
	ewarn "/usr/share/${PN}/nonroot.sh"
	ewarn "to add approprate rules to your hotplug scripts"
	echo
}

pkg_config() {
	"${ROOT}"/usr/share/${PN}/nonroot.sh || die "config failed"
}
