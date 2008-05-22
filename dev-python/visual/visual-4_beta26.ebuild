# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/visual/visual-4_beta26.ebuild,v 1.1 2008/05/22 20:42:15 bicatali Exp $

inherit eutils distutils versionator multilib

MY_P=$(replace_version_separator _ . ${P})

S="${WORKDIR}/${MY_P}"

DESCRIPTION="An easy to use Real-time 3D graphics library for Python."
SRC_URI="mirror://sourceforge/visualpython/${MY_P}.tar.bz2"
HOMEPAGE="http://www.vpython.org/"

IUSE="doc examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="visual"

DEPEND="dev-libs/boost
		virtual/opengl
		=dev-cpp/gtkglextmm-1.2*
		dev-cpp/libglademm
		dev-python/numpy"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-example-dir=/usr/share/doc/${PF}/examples \
		$(use_enable doc docs) \
		$(use_enable examples) \
		|| die "econf failed"

	sed -i s/boost_thread/boost_thread-mt/ src/Makefile

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	python_version

	mv "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/cvisualmodule* \
		"${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/visual

	#the vpython script does not work, and is unnecessary
	rm "${D}"/usr/bin/vpython
}
