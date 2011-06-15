# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ApE/ApE-2.0.7.ebuild,v 1.1 2011/06/15 16:11:04 je_fro Exp $

EAPI=2
inherit eutils

DESCRIPTION="ApE - A Plasmid Editor"
HOMEPAGE="http://www.biology.utah.edu/jorgensen/wayned/ape/"
SRC_URI="http://www.biology.utah.edu/jorgensen/wayned/ape/Download/ApE_linux_current.zip -> ${P}.zip"

LICENSE="ApE"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="dev-lang/tcl
	 dev-lang/tk"

src_compile() {
	echo
	einfo "Nothing to compile."
	echo
}

src_install() {

cat >> "${T}/ApE" << EOF
#!/bin/bash
exec tclsh /usr/share/${P}/AppMain.tcl
EOF

exeinto /usr/bin
doexe "${T}/ApE"
insinto "/usr/share/${P}"
doins -r "${WORKDIR}"/ApE\ Linux/*
make_desktop_entry ${PN} \
		ApE \
		"/usr/share/${P}/Accessory Files/Icons and images/monkey_icon.gif" \
		"Application;Graphics;Science"
}
