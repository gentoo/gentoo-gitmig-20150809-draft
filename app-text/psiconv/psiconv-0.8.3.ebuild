# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/psiconv/psiconv-0.8.3.ebuild,v 1.8 2004/07/14 02:24:28 agriffis Exp $

IUSE="doc"

DESCRIPTION="An interpreter for Psion 5(MX) file formats"
HOMEPAGE="http://huizen.dds.nl/~frodol/psiconv"
SRC_URI="http://huizen.dds.nl/~frodol/psiconv/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc alpha ~mips ~hppa"

DEPEND="virtual/libc"

src_compile() {

	local myconf

	use doc \
		&& myconf="${myconf} enable-html4-docs \
			--enable-ascii-docs \
			--enable-rtf-docs"

	econf || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
