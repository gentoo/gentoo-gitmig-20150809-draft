# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gopenmol/gopenmol-3.00.ebuild,v 1.1 2005/12/03 04:25:44 spyderous Exp $

inherit eutils

DESCRIPTION="gOpenMol is a tool for the visualization and analysis of molecular structures"
HOMEPAGE="http://www.csc.fi/gopenmol"
SRC_URI="${HOMEPAGE}/distribute/${P}-linux.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=dev-lang/tcl-8.4*
	=dev-lang/tk-8.4*
	dev-tcltk/bwidget
	virtual/opengl
	virtual/glut
	media-libs/jpeg
	dev-lang/python
	|| ( (
			x11-libs/libXmu
			x11-libs/libICE
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXi
			x11-libs/libXxf86vm
		)
		virtual/x11
	)"

DEPEND="${RDEPEND}"

S="${WORKDIR}/gOpenMol-${PV}/src"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-include-config-for-plugins.patch
}

src_compile() {
	econf || die "./configure failed"

	emake || die "emake failed"

	# Plugins are not build by default
	cd ${S}/plugins
	emake || die "emake failed"
}

src_install() {
	einstall || die

	cd ${S}/plugins
	einstall || die

	dosed /usr/bin/rungOpenMol
}

pkg_postinst() {
	einfo "Run gOpenMol using the rungOpenMol script."
}
