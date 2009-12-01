# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/griffith/griffith-0.10-r1.ebuild,v 1.1 2009/12/01 17:31:27 hwoarang Exp $

EAPI="2"

inherit eutils versionator python multilib

ARTWORK_PV="0.9.4"

DESCRIPTION="Movie collection manager"
HOMEPAGE="http://griffith.berlios.de/"
SRC_URI="mirror://berlios/griffith/${P/_/-}.tar.gz
	mirror://berlios/griffith/${PN}-extra-artwork-${ARTWORK_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="csv doc spell"

RDEPEND="dev-python/imaging
	gnome-base/libglade
	dev-python/pyxml
	>=dev-python/pygtk-2.6.1
	dev-python/pysqlite:2
	>=dev-python/sqlalchemy-0.5.2
	>=dev-python/reportlab-1.19
	csv? ( dev-python/chardet )
	spell? ( >=dev-python/gnome-python-extras-2.0 )"
DEPEND="${RDEPEND}
	doc? ( app-text/docbook2X )"

S="${WORKDIR}"/"${P/_/-}"
src_prepare() {
	sed -i \
		-e 's#/pl/#/pl.UTF-8/#' \
		"${S}"/docs/pl/Makefile || die "sed failed"

	sed -i \
		-e 's/ISO-8859-1/UTF-8/' \
		"${S}"/lib/gconsole.py || die "sed failed"
	epatch "${FILESDIR}/$(get_version_component_range 1-2)-fix_lib_path.patch"
}

src_compile() {
	# Nothing to compile and default `emake` spews an error message
	true
}

src_install() {
	use doc || sed -i -e '/docs/d' Makefile

	python_version
	emake \
		LIBDIR="${D}/usr/$(get_libdir)/griffith" \
		DESTDIR="${D}" DOC2MAN=docbook2man.pl install || die "emake install failed"
	dodoc AUTHORS ChangeLog README THANKS TODO NEWS TRANSLATORS

	cd "${WORKDIR}/${PN}-extra-artwork-${ARTWORK_PV}/"
	emake DESTDIR="${D}" install || die "emake install artwork failed"
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
