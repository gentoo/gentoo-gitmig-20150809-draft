# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycdio/pycdio-0.13.ebuild,v 1.2 2008/05/14 23:05:01 sbriesen Exp $

inherit eutils distutils flag-o-matic multilib

DESCRIPTION="pycdio is a Python interface to the CD Input and Control library (libcdio)"
HOMEPAGE="http://savannah.gnu.org/projects/libcdio/"
SRC_URI="http://ftp.gnu.org/gnu/libcdio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="virtual/python
	dev-libs/libcdio"

DEPEND="${RDEPEND}
	dev-lang/swig"

PYTHON_MODNAME=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove obsolete sys.path and adjust 'data' path in examples
	sed -i -e "s:^sys.path.insert.*::" -e "s:\.\./data:./data:g" example/*.py.in
}

src_compile() {
	# -fPIC is needed for shared objects on some platforms (amd64 and others)
	append-flags -fPIC

	distutils_src_compile
}

src_install(){
	make DESTDIR="${D}" install || die "make install failed."
	chmod a+x "${D}"usr/$(get_libdir)/python*/site-packages/*.so
	rm -f "${D}"usr/$(get_libdir)/python*/site-packages/*.py[co]

	dodoc AUTHORS NEWS README

	if use doc; then
		insinto /usr/share/doc/${PF}/examples
		doins example/{README,*.py}
		doins -r data
	fi
}

pkg_postinst() {
	python_version
	for pymod in cdio pycdio iso9660 pyiso9660; do
		python_mod_compile "${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages/${pymod}.py
	done
}
