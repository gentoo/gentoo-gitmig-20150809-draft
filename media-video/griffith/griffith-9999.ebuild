# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/griffith/griffith-9999.ebuild,v 1.7 2011/08/05 09:39:16 hwoarang Exp $

EAPI="3"
ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/griffith/trunk"

inherit eutils python multilib subversion

ARTWORK_PV="0.9.4"

DESCRIPTION="Movie collection manager"
HOMEPAGE="http://griffith.berlios.de/"
SRC_URI="mirror://berlios/griffith/${PN}-extra-artwork-${ARTWORK_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="csv doc spell"

RDEPEND="dev-python/imaging
	dev-util/glade:3
	dev-python/pyxml
	>=dev-python/pygtk-2.6.1:2
	dev-python/pygobject:2
	dev-python/pysqlite:2
	>=dev-python/sqlalchemy-0.5.2
	>=dev-python/reportlab-1.19
	>=dev-python/sqlalchemy-0.4.6
	csv? ( dev-python/chardet )
	spell? ( dev-python/gtkspell-python )"
DEPEND="${RDEPEND}
	doc? ( app-text/docbook2X )"

pkg_setup() {
	ewarn "This version is _not_ compatible with databases created with previous versions"
	ewarn "of griffith and the database upgrade is currently (16 Aug 2008) broken."
	ewarn "Please move your ~/.griffith away before starting."
}

src_unpack() {
	unpack ${A}
	subversion_src_unpack
}

src_prepare() {
	cd "${S}"
	sed -i \
		-e 's#/pl/#/pl.UTF-8/#' \
		docs/pl/Makefile || die "sed failed"

	sed -i \
		-e 's/ISO-8859-1/UTF-8/' \
		lib/gconsole.py || die "sed failed"

	sed -i \
		-e "s|locations\['lib'\], '..')|locations\['lib'\], '..', '..', 'share', 'griffith')|" \
		lib/initialize.py || die "sed failed"

	# this patch has to go upstream
	epatch "${FILESDIR}"/fix_lib_path.patch
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
	einfo
	einfo "${PN} can make use of the following optional dependencies"
	einfo "dev-python/chardet: CSV file encoding detections"
	einfo "dev-python/mysql-python: Python interface for MySQL connectivity"
	einfo ">=dev-python/psycopg-2.4: Python interface for PostgreSQL connectivity"
	einfo
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
