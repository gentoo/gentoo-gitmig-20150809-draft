# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nemerle/nemerle-0.3.1.ebuild,v 1.2 2005/05/24 23:36:38 latexer Exp $

inherit mono eutils

DESCRIPTION="A hybrid programming language for the .NET platform"
HOMEPAGE="http://www.nemerle.org/"
SRC_URI="http://www.nemerle.org/download/${P}.tar.bz2"

LICENSE="nemerle"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/mono-1.0
		>=dev-lang/python-2.3
		>=dev-libs/libxml2-2.6.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-pathfix.diff || die "epatch failed"

	# Fixes to not do AOT stuff. Mono's AOT is still in
	# testing, and only works on x86
	#sed -i "s:\(.*\)(NGEN\(.*\):#\1(NGEN\2:" \
		#${S}/ncc/Makefile || die "sed failed"
}

src_compile() {
	./configure --net-engine=/usr/bin/mono \
			--prefix=/usr \
			--mandir=/usr/share/man/man1 || die "configure failed!"
	emake -j1 || die "make failed!"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
