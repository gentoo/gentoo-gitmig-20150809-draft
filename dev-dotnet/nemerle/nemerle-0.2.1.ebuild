# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nemerle/nemerle-0.2.1.ebuild,v 1.1 2004/09/29 23:09:03 latexer Exp $

inherit mono

DESCRIPTION="A hybrid programming language for the .NET platform"
HOMEPAGE="http://www.nemerle.org/"
SRC_URI="http://www.nemerle.org/download/${P}.tar.gz"

LICENSE="nemerle"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-dotnet/mono-1.0
		>=dev-lang/python-2.3
		>=dev-libs/libxml2-2.6.4"

src_compile() {
	./configure --net-engine=/usr/bin/mono \
			--prefix=/usr \
			--mandir=/usr/share/man/man1 || die "configure failed!"
	make || die "make failed!"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
