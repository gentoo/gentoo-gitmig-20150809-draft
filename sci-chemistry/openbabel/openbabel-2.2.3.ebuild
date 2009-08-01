# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/openbabel/openbabel-2.2.3.ebuild,v 1.1 2009/08/01 15:22:51 cryos Exp $

EAPI=1

inherit eutils

DESCRIPTION="interconverts file formats used in molecular modeling"
HOMEPAGE="http://openbabel.sourceforge.net/"
SRC_URI="mirror://sourceforge/openbabel/${P}.tar.gz"

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="doc python swig"

RDEPEND="!sci-chemistry/babel
	>=dev-libs/libxml2-2.6.5
	sys-libs/zlib
	python? ( dev-lang/python )"

DEPEND="${RDEPEND}
	>=dev-libs/boost-1.35.0
	dev-lang/perl
	python? ( swig? ( >=dev-lang/swig-1.3.38 ) )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.2.0-doxyfile.patch"
}

src_compile() {
	local swigconf=""
	if use swig; then
		swigconf="--enable-maintainer-mode"
	fi
	econf ${swigconf} || die "econf failed"
	emake || die "emake failed"
	if use doc ; then
		emake docs || die "make docs failed"
	fi
	if use swig; then
		emake scripts/python/openbabel_python.cpp \
			|| die "Failed to make SWIG python bindings"
	fi
	if use python; then
		cd "${S}/scripts/python"
		python setup.py build || die "Python build failed."
	fi
}

src_test() {
	emake check || die "make check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	# Now to install the Python bindings if necessary
	if use python; then
		cd "${S}/scripts/python"
		python ./setup.py install --root="${D}" --optimize=1 \
			|| die "Python bindings install failed"
		if use doc; then
			docinto python
			dodoc README
			docinto python/html
			dodoc *.html
		fi
	fi
	# And the documentation
	docinto
	cd "${S}"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	cd doc
	dohtml *.html *.png
	dodoc *.inc README* *.inc *.mol2
	if use doc ; then
		dodir /usr/share/doc/${PF}/API/html
		insinto /usr/share/doc/${PF}/API/html
		cd API/html
		doins *
	fi
}
