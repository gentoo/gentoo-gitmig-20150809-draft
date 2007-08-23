# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.6.ebuild,v 1.6 2007/08/23 16:27:51 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Your basic line editor"
HOMEPAGE="http://www.gnu.org/software/ed/"
SRC_URI="mirror://gnu/ed/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ~ia64 m68k mips ~ppc ~ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.5-build.patch
}

src_compile() {
	tc-export CC CXX
	# custom configure script ... econf wont work
	./configure \
		--prefix=/ \
		--datadir=/usr/share \
		${EXTRA_ECONF} \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	doman doc/ed.1
	dosym ed.1 /usr/share/man/man1/red.1
	dodoc AUTHORS ChangeLog NEWS README TODO
}
