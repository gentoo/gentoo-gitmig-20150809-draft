# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/psiconv/psiconv-0.8.3.ebuild,v 1.4 2004/02/29 18:10:25 aliz Exp $

IUSE="doc"

S=${WORKDIR}/${P}
DESCRIPTION="An interpreter for Psion 5(MX) file formats"
HOMEPAGE="http://huizen.dds.nl/~frodol/psiconv"
SRC_URI="http://huizen.dds.nl/~frodol/psiconv/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="virtual/glibc"

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
