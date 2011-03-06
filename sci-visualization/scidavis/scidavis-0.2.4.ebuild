# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/scidavis/scidavis-0.2.4.ebuild,v 1.4 2011/03/06 09:10:57 jlec Exp $

EAPI="3"

inherit eutils fdo-mime prefix qt4-r2

DESCRIPTION="Scientific Data Analysis and Visualization"
HOMEPAGE="http://scidavis.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

LANGS="de es fr ja ru sv"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

CDEPEND="sys-libs/zlib
	x11-libs/qwt:5[svg]
	>=x11-libs/qwtplot3d-0.2.7
	|| ( >=x11-libs/qt-assistant-4.7.0:4[compat] <x11-libs/qt-assistant-4.7.0:4 )
	x11-libs/qt-qt3support:4
	>=dev-cpp/muParser-1.30
	>=sci-libs/gsl-1.8"
# remove because unsupported for now
#	sci-libs/liborigin:2"

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	>=dev-python/sip-4.7"

RDEPEND="${CDEPEND}
	>=dev-python/PyQt4-4.4[X]
	dev-python/pygsl
	sci-libs/scipy"

DOCS="README CHANGES"

src_prepare() {
	epatch "${FILESDIR}"/${P}-profile.patch
	eprefixify ${PN}/${PN}.pro
	sed -i -e '/lgsl/d' fitPlugins/*/*.pro || die "sed gsl link failed"
	sed -i \
		-e "s:doc/${PN}:doc/${PF}:g" \
		${PN}/${PN}.pro || die "sed doc dir failed"
	# the libsuff thingy does not work
	sed -i \
		-e "s|/usr/lib\$\${libsuff}|/usr/$(get_libdir)|g" \
		-i fit*/*/*.pro || die "sed plugins failed"

	sed -i \
		-e '/^include( python.pri )$/d' \
		${PN}/${PN}.pro || die "sed python failed"
}

src_install() {
	qt4-r2_src_install

	doicon scidavis/icons/hicolor-48/scidavis.png || die
	cd ${PN}/translations
	insinto /usr/share/${PN}/translations
	for l in ${LANGS}; do
		if use linguas_${l}; then
			doins ${PN}_${l}.qm || die
		fi
	done
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
