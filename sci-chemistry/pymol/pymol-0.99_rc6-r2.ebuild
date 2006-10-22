# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol/pymol-0.99_rc6-r2.ebuild,v 1.3 2006/10/22 18:41:55 ribosome Exp $

inherit distutils eutils multilib

MY_PV=${PV/_}
MY_S_P="${PN}-${MY_PV}"
MY_PV=${MY_PV/./_}
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A Python-extensible molecular graphics system."
HOMEPAGE="http://pymol.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymol/${MY_P}-src.tgz"

LICENSE="PSF-2.2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-lang/python
	dev-python/pmw
	dev-python/numeric
	dev-lang/tk
	media-libs/libpng
	sys-libs/zlib
	media-libs/glut"

S="${WORKDIR}/${MY_S_P}"

pkg_setup() {
	distutils_python_tkinter
}

src_unpack() {
	unpack ${A}
	cd "${S}"/modules/${PN}
	epatch "${FILESDIR}"/${P}-data-path.patch
	cd "${S}"
	# Turn off splash screen.  Please do make a project contribution
	# if you are able though.
	[[ -n "$WANT_NOSPLASH" ]] && epatch "${FILESDIR}"/nosplash-gentoo.patch

	# Respect CFLAGS
	sed -i \
		-e "s:\(ext_comp_args=\).*:\1[]:g" \
		"${S}"/setup.py
}

src_install() {
	python_version

	distutils_src_install
	cd "${S}"

	#The following three lines probably do not do their jobs and should be
	#changed
	PYTHONPATH="${D}/usr/$(get_libdir)/site-packages" ${python} setup2.py

	# These environment variables should not go in the wrapper script, or else
	# it will be impossible to use the PyMOL libraries from Python.
cat >> "${T}"/20pymol << EOF
PYMOL_PATH=/usr/lib/python${PYVER}/site-packages/pymol
PYMOL_DATA="/usr/share/pymol/data"
PYMOL_SCRIPTS="/usr/share/pymol/scripts"
EOF

	doenvd "${T}"/20pymol || die "Failed to install env.d file."

	# Make our own wrapper
cat >> "${T}"/pymol << EOF
#!/bin/sh
${python} \${PYMOL_PATH}/__init__.py \$*
EOF

	exeinto /usr/bin
	doexe "${T}"/pymol || die "Failed to install wrapper."
	dodoc DEVELOPERS CHANGES || die "Failed to install docs."

	mv examples "${D}"/usr/share/doc/${PF}/ || die "Failed moving docs."

	dodir /usr/share/pymol
	mv test "${D}"/usr/share/pymol/ || die "Failed moving test files."
	mv data "${D}"/usr/share/pymol/ || die "Failed moving data files."
	mv scripts "${D}"/usr/share/pymol/ || die "Failed moving scripts."
}
