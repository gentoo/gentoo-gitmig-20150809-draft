# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol/pymol-0.99.ebuild,v 1.2 2006/03/04 00:23:27 halcy0n Exp $

inherit distutils eutils multilib

MY_P="${PN}-${PV/./_}rc1"
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

src_unpack() {
	unpack ${A}
	cd ${S}

	# Respect CFLAGS
	sed -i \
		-e "s:\(ext_comp_args=\).*:\1[]:g" \
		${S}/setup.py
}

src_install() {
	python_version

	distutils_src_install
	cd ${S}

	#The following three lines probably do not do their jobs and should be
	#changed
	PYTHONPATH="${D}/usr/$(get_libdir)/site-packages" ${python} setup2.py

	# Make our own wrapper
cat >> ${T}/pymol << EOF
#!/bin/sh
PYMOL_PATH=/usr/lib/python${PYVER}/site-packages/pymol
PYMOL_DATA="/usr/share/pymol/data"
PYMOL_SCRIPTS="/usr/share/pymol/scripts"
export PYMOL_PATH PYMOL_DATA PYMOL_SCRIPTS
${python} \${PYMOL_PATH}/__init__.py \$*
EOF

	exeinto /usr/bin
	doexe ${T}/pymol
	dodoc DEVELOPERS CHANGES

	mv examples ${D}/usr/share/doc/${PF}/

	dodir /usr/share/pymol
	mv tests ${D}/usr/share/pymol/
	mv data ${D}/usr/share/pymol/
	mv scripts ${D}/usr/share/pymol/
}
