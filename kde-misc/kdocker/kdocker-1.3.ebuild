# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdocker/kdocker-1.3.ebuild,v 1.3 2008/07/27 20:52:18 carlo Exp $

EAPI=1

inherit eutils qt3

IUSE=""
LANGS="cs de en es fr id it pl pt_BR ru"
for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done;

DESCRIPTION="KDocker will help you dock any application in the system tray"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=13356"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-desktop_file.patch
	epatch "${FILESDIR}"/${PN}-installdir.patch
}

src_compile() {
	${QTDIR}/bin/qmake ${PN}.pro \
		QMAKE=${QTDIR}/bin/qmake \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_RPATH= \
		"CONFIG += no_fixpath release thread" \
		|| die "couldn't create fresh Makefiles"
	emake || die "make failed"

	# langpacks
	cd "${S}"/i18n
	for i in ${LANGS}; do
		use linguas_${i} && [ -f ${PN}_${i}.ts ] && lrelease ${PN}_${i}.ts
	done;
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "installation failed"

	dodoc AUTHORS BUGS CREDITS ChangeLog HACKING INSTALL README TODO

	# langpacks are being installed only if
	# approperiare LINGUAS variable is set
	insinto /usr/share/${PN}/i18n
	cd "${S}"/i18n
	for i in ${LANGS}; do
		use linguas_${i} && [ -f ${PN}_${i}.qm ] && doins ${PN}_${i}.qm
	done;
}
