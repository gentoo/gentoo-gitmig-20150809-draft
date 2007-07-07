# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/kicad/kicad-20070115.ebuild,v 1.9 2007/07/07 08:44:26 calchan Exp $

inherit wxwidgets

UPSTREAM_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
DESCRIPTION="Electronic schematic and PCB design tools."
HOMEPAGE="http://www.lis.inpg.fr/realise_au_lis/kicad/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	!minimal? ( ftp://iut-tice.ujf-grenoble.fr/cao/${PN}-${UPSTREAM_PV}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc64 x86"
IUSE="unicode doc examples minimal"

DEPEND="=x11-libs/wxGTK-2.6*"

pkg_setup() {
	# Tell wxwidgets.eclass which version we need
	WX_GTK_VER="2.6"

	# Check for proper wxGTK USE flags.
	if use unicode; then
		need-wxwidgets unicode || die "You need to install wxGTK with unicode support."
	else
		need-wxwidgets gtk2 || die "You need to install wxGTK with gtk2 support."
	fi
	built_with_use "=x11-libs/wxGTK-${WX_GTK_VER}*" opengl || die "You need to install wxGTK with opengl support."
}

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}

	# Use the chosen wx-config executable
	sed -i -e "s:wx-config:${WX_CONFIG}:" libs.* || die "sed failed"
	sed -i -e "s:wx-config:${WX_CONFIG}:" */makefile.* || die "sed failed"
}

src_compile() {
	# Build the main executables
	emake -f makefile.gtk || die "make failed (main)"

	# Minizip needs to be built independently
	cd kicad/minizip
	emake -f makefile.unx || die "make failed (minizip)"
}

src_install() {
	# kicad doesn't use the autotools yet
	exeinto /usr/lib/${PN}/linux
	doexe eeschema/eeschema
	doexe pcbnew/pcbnew
	doexe cvpcb/cvpcb
	doexe kicad/kicad
	doexe kicad/minizip/minizip
	doexe gerbview/gerbview
	exeinto /usr/lib/${PN}/linux/plugins
	doexe eeschema/plugins/netlist_form_pads-pcb
	newicon kicad_icon.png kicad.png
	make_wrapper kicad "/usr/lib/${PN}/linux/kicad"
	make_desktop_entry kicad Kicad kicad.png Electronics

	# kicad requires everything to be in the same place
	cp -pPR library ${D}/usr/lib/${PN}
	cp -pPR internat ${D}/usr/lib/${PN}
	cp -pPR template ${D}/usr/lib/${PN}
	cp -pPR help ${D}/usr/lib/${PN}
	if ! use minimal ; then
		cp -pPR ${WORKDIR}/kicad/library ${D}/usr/lib/${PN}
		cp -pPR ${WORKDIR}/kicad/modules ${D}/usr/lib/${PN}
		cp -pPR ${WORKDIR}/kicad/template ${D}/usr/lib/${PN}
		if use doc ; then
			cp -pPR ${WORKDIR}/kicad/help ${D}/usr/lib/${PN}
		fi
		if use examples ; then
			cp -pPR ${WORKDIR}/kicad/demos ${D}/usr/lib/${PN}
		fi
	fi
	dodoc author.txt copyright.txt news.txt contrib.txt version.txt
}

pkg_postinst() {
	if use minimal ; then
		ewarn "If the schematic and/or board editors complain about missing libraries when you open old projects,"
		ewarn "you will have to take one or more of the following actions :"
		ewarn "- Install the missing libraries manually."
		ewarn "- Remove the libraries from the 'Libs and Dir' preferences."
		ewarn "- Fix the libraries' locations in the 'Libs and Dir' preferences."
		ewarn "- Emerge kicad without the 'minimal' USE flag."
	else
		elog "Please note that the PDF datasheets that can be linked to components from the default libraries"
		elog "cannot be mirrored by Gentoo for legal reasons."
		elog "If you want them, you need to download them yourself from :"
		elog "${HOMEPAGE}"
		elog "and install them manually."
	fi
	elog
	elog "You may want to emerge media-gfx/wings if you want to create 3D models of components."
}
