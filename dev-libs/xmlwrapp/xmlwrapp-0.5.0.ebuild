# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlwrapp/xmlwrapp-0.5.0.ebuild,v 1.1 2004/09/20 16:44:48 usata Exp $

inherit eutils

DESCRIPTION="modern style C++ library that provides a simple and easy interface to libxml2"
HOMEPAGE="http://pmade.org/software/xmlwrapp/"
SRC_URI="http://pmade.org/software/xmlwrapp/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc
	dev-lang/perl
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo.diff
}

src_compile() {
	perl configure.pl --prefix /usr || die
	emake || die
}

src_install() {
	sed -i "s%/usr%${D}/usr%g" Makefile
	make install || die

	dodoc README docs/{CREDITS,TODO,VERSION}
	cd docs
	for doc in {manual,project} ; do
		insinto /usr/share/doc/${PF}/$doc
		doins $doc/*.xml
	done
}
