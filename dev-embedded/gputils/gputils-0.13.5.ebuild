# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gputils/gputils-0.13.5.ebuild,v 1.1 2007/11/28 21:05:54 calchan Exp $

inherit eutils

DESCRIPTION="Collection of tools including assembler, linker and librarian for PIC microcontrollers."
HOMEPAGE="http://gputils.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	http://dev.gentoo.org/~calchan/distfiles/${P}-maxrom.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PN}-0.13.4-mapping.patch" || die "Patching failed"
	epatch "../${P}-maxrom.patch"  || die "Patching failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Installation failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/gputils.ps
	insinto /usr/share/doc/${PF}/
	doins doc/gputils.pdf
}
