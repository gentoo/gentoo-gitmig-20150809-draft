# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/visual-regexp/visual-regexp-3.0.ebuild,v 1.1 2004/05/02 17:50:36 kloeri Exp $

LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="software that allows yoy ty type the regexp, and visualize it on a sample of your choice"
SRC_URI="http://laurent.riesterer.free.fr/regexp/visual_regexp-${PV}.tar.gz"
HOMEPAGE="http://laurent.riesterer.free.fr/regexp/"
SLOT="0"

IUSE=""

DEPEND=">=dev-lang/tcl-8.3
	>=dev-lang/tk-8.3"

S="${WORKDIR}/visual_regexp-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/wish-fix.diff
}

src_install() {
	dodoc README

	exeinto /usr/bin
	newexe visual_regexp.tcl visualregexp

	dosym /usr/bin/visualregexp /usr/bin/tkregexp

	insinto /usr/share/pixmaps/visualregexp
	doins ${FILESDIR}/visualregexp-icon.png

	insinto /usr/share/applications
	doins ${FILESDIR}/visualregexp.desktop
}
