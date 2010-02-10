# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol/pymol-1.2.2-r2.ebuild,v 1.1 2010/02/10 11:22:34 jlec Exp $

EAPI="2"

inherit eutils distutils

PYTHON_MODNAME="chempy pmg_tk pymol"
REV="3859"

DESCRIPTION="A Python-extensible molecular graphics system."
HOMEPAGE="http://pymol.sourceforge.net/"
SRC_URI="http://pymol.svn.sourceforge.net/viewvc/pymol/trunk/pymol.tar.gz?view=tar&pathrev=${REV} -> ${P}.tar.gz"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apbs numpy shaders vmd"

DEPEND=">=dev-lang/python-2.4[tk]
		dev-python/numpy
		dev-python/pmw
		media-libs/freetype:2
		media-libs/libpng
		media-video/mpeg-tools
		sys-libs/zlib
		virtual/glut
		apbs? (
			dev-libs/maloc
			sci-chemistry/apbs
			sci-chemistry/pdb2pqr
			sci-chemistry/pymol-apbs-plugin
		)"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

pkg_setup(){
	python_version
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-data-path.patch \
		|| die "Failed to apply data-path.patch"

	# Turn off splash screen.  Please do make a project contribution
	# if you are able though. #299020
	epatch "${FILESDIR}"/1.2.1/nosplash-gentoo.patch

	# Respect CFLAGS
	sed -i \
		-e "s:\(ext_comp_args=\).*:\1[]:g" \
		"${S}"/setup.py || die "Failed running sed on setup.py"

	use shaders && epatch "${FILESDIR}"/${P}-shaders.patch

	use vmd && epatch "${FILESDIR}"/${P}-vmd.patch

	use numpy && \
		sed \
			-e '/PYMOL_NUMPY/s:^#::g' \
			-i setup.py
}

src_configure() {
	:
}

src_install() {
	distutils_src_install

	# These environment variables should not go in the wrapper script, or else
	# it will be impossible to use the PyMOL libraries from Python.
	cat >> "${T}"/20pymol <<- EOF
		PYMOL_PATH=$(python_get_sitedir)/${PN}
		PYMOL_DATA="/usr/share/pymol/data"
		PYMOL_SCRIPTS="/usr/share/pymol/scripts"
	EOF

	doenvd "${T}"/20pymol || die "Failed to install env.d file."

	cat >> "${T}"/pymol <<- EOF
	#!/bin/sh
	${python} -O \${PYMOL_PATH}/__init__.py \$*
	EOF

	dobin "${T}"/pymol || die "Failed to install wrapper."

	insinto /usr/share/pymol
	doins -r test data scripts || die "no shared data"

	insinto /usr/share/pymol/examples
	doins -r examples || die "Failed to install docs."

	dodoc DEVELOPERS README || die "Failed to install docs."

	rm "${D}"$(python_get_sitedir)/pmg_tk/startup/apbs_tools.py
}
