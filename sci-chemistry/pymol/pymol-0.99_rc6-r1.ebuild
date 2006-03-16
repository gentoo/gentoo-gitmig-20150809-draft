# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol/pymol-0.99_rc6-r1.ebuild,v 1.1 2006/03/16 03:41:54 ribosome Exp $

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
	virtual/glut"
S="${WORKDIR}/${MY_S_P}"

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

	# Make our own wrapper
cat >> "${T}"/pymol << EOF
#!/bin/sh
PYMOL_PATH=/usr/lib/python${PYVER}/site-packages/pymol
PYMOL_DATA="/usr/share/pymol/data"
PYMOL_SCRIPTS="/usr/share/pymol/scripts"
export PYMOL_PATH PYMOL_DATA PYMOL_SCRIPTS
${python} \${PYMOL_PATH}/__init__.py \$*
EOF

	exeinto /usr/bin
	doexe "${T}"/pymol
	dodoc DEVELOPERS CHANGES

	mv examples "${D}"/usr/share/doc/${PF}/

	dodir /usr/share/pymol
	mv test "${D}"/usr/share/pymol/
	mv data "${D}"/usr/share/pymol/
	mv scripts "${D}"/usr/share/pymol/
}
