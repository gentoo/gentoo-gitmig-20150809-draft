# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/staden-emboss/staden-emboss-1.4.1.ebuild,v 1.1 2004/09/16 19:12:39 ribosome Exp $

DESCRIPTION="tcl/tk GUIs for using EMBOSS applications within the Staden Package"
HOMEPAGE="http://staden.sourceforge.net/"
SRC_URI=""
LICENSE="staden"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-sci/emboss
	app-sci/staden"

S=${WORKDIR}

pkg_setup() {
	# Check for X authority.
	if [ -z ${XAUTHORITY} ]; then
		echo
		eerror 'The "XAUTHORITY" environment variable is not set on your system.'
		eerror 'Access to an X display is required to build the EMBOSS tcl/tk GUIs.'
		eerror 'Please either unset the "emboss" "USE" flag to install this package'
		eerror 'without building the EMBOSS GUIs (you will still be provided with a'
		eerror 'set of prebuilt GUIs) or configure access to an X display. You can'
		eerror 'transfer the X credentials of an ordinary user to the account you'
		eerror 'use to execute "emerge" with the "sux" command, which is part of the'
		eerror '"x11-misc/sux" package. See: "http://www.gentoo.org/doc/en/su-x.xml"'
		eerror 'for an introduction to installing and using "sux" on Gentoo.'
		die '"XAUTHORITY" not set.'
	fi
}

src_unpack() {
	einfo "Preparing build environment."
	cp -r /opt/staden/lib ${S}/lib
	cp -r /opt/staden/linux-bin ${S}/linux-bin
	cp -r /opt/staden/tables ${S}/tables
	mkdir ${S}/lib/spin2_emboss/acdtcl
}

src_compile() {
	einfo "Building EMBOSS tcl/tk GUIs."
	cd ${S}/linux-bin
	STADENROOT="${S}" ${S}/linux-bin/create_emboss_files || die
}

src_install() {
	mkdir -p ${D}/opt/staden/lib/spin2_emboss/acdtcl
	mkdir ${D}/opt/staden/tables
	mv ${S}/lib/spin2_emboss/acdtcl/* ${D}/opt/staden/lib/spin2_emboss/acdtcl
	mv ${S}/tables/emboss_menu ${D}/opt/staden/tables/emboss_menu
}

pkg_postinst() {
	echo
	einfo 'The "spin" program (which is part of the Staden Package) should'
	einfo 'now contain an "Emboss" menu allowing access to the GUIs.'
	echo
}
