# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/visual-regexp/visual-regexp-3.0.ebuild,v 1.4 2004/06/25 02:50:05 agriffis Exp $

inherit eutils

DESCRIPTION="software that allows yoy ty type the regexp, and visualize it on a sample of your choice"
HOMEPAGE="http://laurent.riesterer.free.fr/regexp/"
SRC_URI="http://laurent.riesterer.free.fr/regexp/visual_regexp-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
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
