# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gopenmol/gopenmol-3.00-r1.ebuild,v 1.3 2010/09/16 17:25:29 scarabeus Exp $

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
	media-libs/freeglut
	media-libs/jpeg
	dev-lang/python
	x11-libs/libXmu
	x11-libs/libICE
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXi
	x11-libs/libXxf86vm"

DEPEND="${RDEPEND}"

S="${WORKDIR}/gOpenMol-${PV}/src"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-include-config-for-plugins.patch
}

src_compile() {
	econf || die "./configure failed"

	emake || die "emake failed"

	# Plugins are not built by default
	cd ${S}/plugins
	emake || die "emake plugins failed"

	# Utilities are not built by default
	cd ${S}/utility
	emake || die "emake utility failed"
}

src_install() {
	einstall || die "einstall failed"

	cd ${S}/plugins
	einstall || die "einstall plugins failed"

	cd ${S}/utility
	einstall || die "einstall utility failed"

	dosed /usr/bin/rungOpenMol
}

pkg_postinst() {
	einfo "Run gOpenMol using the rungOpenMol script."
}
