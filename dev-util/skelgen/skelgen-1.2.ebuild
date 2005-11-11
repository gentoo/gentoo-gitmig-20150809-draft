# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/skelgen/skelgen-1.2.ebuild,v 1.1 2005/11/11 15:39:41 taviso Exp $

inherit eutils flag-o-matic

DESCRIPTION="A Skeleton Source File Generator"
HOMEPAGE="http://www.fluidstudios.com/"
SRC_URI="http://www.fluidstudios.com/pub/FluidStudios/Tools/Fluid_Studios_Skeleton_Source_File_Generator-${PV}.zip"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""
S=${WORKDIR}/source

# where macros and templates are installed
SGPREFIX="/usr/share/skelgen"

src_unpack() {
	# by default skelgen looks in pwd for macros and templates
	# this changes it to look in /usr/share/skelgen.
	# skelgen allows users to override the path with an env var or 
	# command line argument.
	unpack ${A}; cd ${S}
	einfo "Setting prefix..."
		ebegin "	${SGPREFIX}"
			sed -i 's#\(prefix\)(".");#\1("'${SGPREIX}'");#g' main.cpp || {
				einfo $?
				die "sed failed"
			}
		eend $?
	einfo "...done."
}

src_compile() {
	# Makefile uses $STRIPPER to strip executable, so use true
	# instead and let portage handle that.
	append-flags -c
	emake COMPILER_OPTIONS="${CXXFLAGS}" STRIPPER="true" || die
}

src_install() {
	dobin skelgen
	dodoc readme.txt

	dodir ${SGPREFIX}
	dodir ${SGPREFIX}/macros
	dodir ${SGPREFIX}/templates

	insinto ${SGPREFIX}/macros
	doins macros/{common.macro,personal.macro,work.macro}

	insinto ${SGPREFIX}/templates
	doins templates/{default.{cpp,h},fluid.{cpp,h},gpl.{c,h},skelgen.{cpp,h}}
}
