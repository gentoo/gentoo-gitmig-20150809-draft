# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/staden-emboss/staden-emboss-1.4.1.ebuild,v 1.3 2004/09/16 23:18:24 ribosome Exp $

ST="staden"

DESCRIPTION="tcl/tk GUIs for using EMBOSS applications within the Staden Package"
HOMEPAGE="http://${ST}.sourceforge.net/"
LICENSE="${ST}"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-sci/emboss
	app-sci/staden"

S=${WORKDIR}

pkg_setup() {
	if [ -z ${XAUTHORITY} ]; then
		echo
		eerror 'The "XAUTHORITY" environment variable is not set on your system. Access'
		eerror 'to an X display is required to build the EMBOSS tcl/tk GUIs. You can'
		eerror 'transfer the X credentials of an ordinary user to the account you'
		eerror 'use to execute "emerge" with the "sux" command, which is part of the'
		eerror '"x11-misc/sux" package. See: "http://www.gentoo.org/doc/en/su-x.xml"'
		eerror 'for an introduction to installing and using "sux" on Gentoo.'
		die '"XAUTHORITY" not set.'
	fi
}

src_unpack() {
	einfo "Nothing to unpack."
}

src_compile() {
	STADENROOT="${S}" OUTDIR="${S}" ${STADENROOT}/linux-bin/create_emboss_files || die
}

src_install() {
	mkdir -p ${D}/opt/${ST}/lib/spin2_emboss/acdtcl
	mkdir -p ${D}/opt/${ST}/tables
	mv ${S}/*.acd ${D}/opt/${ST}/lib/spin2_emboss/acdtcl
	mv ${S}/emboss_menu ${D}/opt/${ST}/tables
}

pkg_postinst() {
	echo
	einfo 'The "spin" program (which is part of the Staden Package) should'
	einfo 'now contain an "Emboss" menu allowing access to the GUIs.'
	echo
}
