# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/scidavis/scidavis-0.2.1-r1.ebuild,v 1.1 2009/04/14 18:29:26 bicatali Exp $

EAPI=2
inherit eutils qt4 fdo-mime

DESCRIPTION="Scientific Data Analysis and Visualization"
HOMEPAGE="http://scidavis.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

LANGS="de es fr ja ru sv"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

CDEPEND="sys-libs/zlib
	=x11-libs/qwt-5.1*[svg]
	>=x11-libs/qwtplot3d-0.2.7
	>=dev-cpp/muParser-1.30
	>=sci-libs/gsl-1.8"
# remove because unsupported for now
#	sci-libs/liborigin:2"

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-python/sip-4.7 )"

RDEPEND="${CDEPEND}
	python? ( >=dev-python/PyQt4-4.4
		dev-python/pygsl
		sci-libs/scipy )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-profile.patch
	epatch "${FILESDIR}"/${P}-lupdate.patch
	sed -i -e '/lgsl/d' fitPlugins/*/*.pro || die "sed gsl link failed"
	sed -i \
		-e "s:doc/${PN}:doc/${PF}:g" \
		${PN}/${PN}.pro || die "sed doc dir failed"
	# the libsuff thingy does not work
	sed -i \
		-e "s|/usr/lib\$\${libsuff}|/usr/$(get_libdir)|g" \
		-i fit*/*/*.pro || die "sed plugins failed"

	if use python; then
		sed -i \
			-e '/^include( python.pri )$/d' \
			${PN}/${PN}.pro || die "sed python failed"
	fi
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die 'emake install failed'
	dodoc README CHANGES
	doicon scidavis/icons/hicolor-48/scidavis.png
	cd ${PN}/translations
	insinto /usr/share/${PN}/translations
	for l in ${LANGS}; do
		if use linguas_${l}; then
			doins ${PN}_${l}.qm
		fi
	done
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
