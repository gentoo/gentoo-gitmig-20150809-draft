# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/visual/visual-3.2.1.ebuild,v 1.7 2005/07/13 23:54:23 tercel Exp $

inherit distutils

DESCRIPTION="An easy to use Real-time 3D graphics library for Python."
SRC_URI="http://www.vpython.org/download/${PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.vpython.org/"

IUSE="doc examples numeric numarray"
SLOT="0"
KEYWORDS="x86"
LICENSE="visual"

DEPEND=">=dev-lang/python-2.3
		virtual/opengl
		=x11-libs/gtk+-1.2*
		>=x11-libs/gtkglarea-1.2
		dev-util/pkgconfig
		>=dev-libs/boost-1.31
		numeric? ( dev-python/numeric )
		numarray? ( >=dev-python/numarray-1.0 )
		!numeric? ( !numarray? ( dev-python/numeric ) )"

src_compile() {
	local myconf="--without-numarray --without-numeric"

	echo
	if useq numeric; then
		einfo "Building with Numeric support"
		myconf=${myconf/--without-numeric}
	fi
	if useq numarray; then
		einfo "Building with Numarray support"
		myconf=${myconf/--without-numarray}
	fi
	if ! useq numeric && ! useq numarray; then
		einfo "Support for Numeric or Numarray was not specified."
		einfo "Building with Numeric support"
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
	make DESTDIR="${D}" install || die "install failed"

	python_version

	mv ${D}/usr/lib/python${PYVER}/site-packages/cvisualmodule* \
		${D}/usr/lib/python${PYVER}/site-packages/visual

	#the vpython script does not work, and is unnecessary
	rm ${D}/usr/bin/vpython
}
