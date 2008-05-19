# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/visual/visual-3.2.9.ebuild,v 1.13 2008/05/19 17:12:03 drac Exp $

inherit distutils multilib

DESCRIPTION="An easy to use Real-time 3D graphics library for Python."
SRC_URI="http://www.vpython.org/download/${P}.tar.bz2"
HOMEPAGE="http://www.vpython.org/"

IUSE="doc examples numeric numarray"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
LICENSE="visual"

RDEPEND=">=dev-lang/python-2.3
	virtual/opengl
	=x11-libs/gtk+-1.2*
	=x11-libs/gtkglarea-1.2*
	>=dev-libs/boost-1.31
	numeric? ( dev-python/numeric )
	numarray? ( >=dev-python/numarray-1.0 )
	!numeric? ( !numarray? ( dev-python/numeric ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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

	mkdir -p "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/visual/
	mv "${D}"/usr/lib/python${PYVER}/site-packages/ \
		"${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/visual/

	#the vpython script does not work, and is unnecessary.
	#Also nuke directories that are empty so we don't have
	#empty directories hanging around.
	rm -rf "${D}"/usr/bin/
	rm -rf "${D}"/usr/lib/

}
