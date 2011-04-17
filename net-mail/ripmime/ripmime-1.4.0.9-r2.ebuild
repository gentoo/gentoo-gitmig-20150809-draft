# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripmime/ripmime-1.4.0.9-r2.ebuild,v 1.1 2011/04/17 23:22:42 radhermit Exp $

EAPI="4"

inherit eutils multilib toolchain-funcs

DESCRIPTION="extract attachment files out of a MIME-encoded email pack"
HOMEPAGE="http://pldaniels.com/ripmime/"
SRC_URI="http://www.pldaniels.com/ripmime/${P}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="static-libs"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-buffer-overflow.patch
}

src_compile() {
	local maketargets="default solib"
	use static-libs && maketargets="${maketargets} libripmime.a"

	emake CC="$(tc-getCC)" AR="$(tc-getAR)" CFLAGS="${CFLAGS}" ${maketargets}
}

src_install() {
	dobin ripmime
	doman ripmime.1
	dodoc CHANGELOG INSTALL README TODO

	insinto /usr/include/ripmime
	doins mime.h ripmime-api.h

	dolib.so libripmime.so.1.4.0
	dosym libripmime.so.1.4.0 /usr/$(get_libdir)/libripmime.so

	if use static-libs ; then
		dolib.a libripmime.a
	fi
}
