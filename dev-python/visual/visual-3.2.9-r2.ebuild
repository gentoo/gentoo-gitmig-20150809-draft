# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/visual/visual-3.2.9-r2.ebuild,v 1.1 2009/02/03 17:59:47 patrick Exp $

inherit distutils

DESCRIPTION="An easy to use Real-time 3D graphics library for Python."
SRC_URI="http://www.vpython.org/download/${P}.tar.bz2"
HOMEPAGE="http://www.vpython.org/"

IUSE="doc examples numeric numarray"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
LICENSE="visual"

RDEPEND="virtual/python
	virtual/opengl
	=x11-libs/gtk+-1.2*
	=x11-libs/gtkglarea-1.2*
	>=dev-libs/boost-1.31
	numeric? ( dev-python/numeric )
	numarray? ( >=dev-python/numarray-1.0 )
	!numeric? ( !numarray? ( dev-python/numeric ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"/site-packages
	epatch "${FILESDIR}/${P}"-import_bug143237.patch
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc43.patch
}

src_compile() {
	local myconf="--without-numarray --without-numeric"

	echo
	if useq numeric; then
		elog "Building with Numeric support"
		myconf=${myconf/--without-numeric}
	fi
	if useq numarray; then
		elog "Building with Numarray support"
		myconf=${myconf/--without-numarray}
	fi
	if ! useq numeric && ! useq numarray; then
		elog "Support for Numeric or Numarray was not specified."
		elog "Building with Numeric support"
		myconf=${myconf/--without-numeric}
	fi
	echo

	econf \
	--with-html-dir=/usr/share/doc/${PF}/html \
	--with-example-dir=/usr/share/doc/${PF}/examples \
	$(use_enable doc docs ) \
	$(use_enable examples ) \
	${myconf} \
	|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	python_version

	insinto $(python_get_sitedir)
	doins -r "${WORKDIR}/${P}"/site-packages/*

	#the vpython script does not work, and is unnecessary.
	#Also nuke directories that are empty so we don't have
	#empty directories hanging around.
	rm -rf "${D}"/usr/bin/

}
