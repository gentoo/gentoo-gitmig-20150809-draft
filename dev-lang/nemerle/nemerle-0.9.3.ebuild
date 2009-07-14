# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nemerle/nemerle-0.9.3.ebuild,v 1.3 2009/07/14 21:28:48 fauli Exp $

inherit mono eutils multilib

DESCRIPTION="A hybrid programming language for the .NET platform"
HOMEPAGE="http://www.nemerle.org/"
SRC_URI="http://www.nemerle.org/download/${P}.tar.bz2"

LICENSE="nemerle"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
DEPEND=">=dev-lang/mono-1.1.9.2
		>=dev-lang/python-2.3
		>=dev-libs/libxml2-2.6.4"
RDEPEND="${DEPEND}"

src_compile() {
	./configure --net-engine=/usr/bin/mono \
		--disable-aot \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man/man1 || die
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
