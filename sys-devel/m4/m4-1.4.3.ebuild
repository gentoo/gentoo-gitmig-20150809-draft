# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4.3.ebuild,v 1.2 2005/04/01 22:54:58 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="GNU macro processor"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	ftp://ftp.seindal.dk/gnu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools.patch
}

src_compile() {
	econf \
		$(use_enable nls) \
		--enable-changeword \
		|| die
	emake AR="$(tc-getAR)" || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc BACKLOG ChangeLog NEWS README* THANKS TODO
}
