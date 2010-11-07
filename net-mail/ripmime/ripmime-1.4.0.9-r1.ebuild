# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripmime/ripmime-1.4.0.9-r1.ebuild,v 1.1 2010/11/07 21:28:26 radhermit Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="extract attachment files out of a MIME-encoded email pack"
HOMEPAGE="http://pldaniels.com/ripmime/"
SRC_URI="http://www.pldaniels.com/ripmime/${P}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="static-libs"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-buffer-overflow.patch
}

src_compile() {
	local maketargets="default solib"
	use static-libs && maketargets="${maketargets} libripmime.a"

	emake CC="$(tc-getCC)" AR="$(tc-getAR)" CFLAGS="${CFLAGS}" ${maketargets} \
		|| die "emake failed"
}

src_install() {
	dobin ripmime || die "dobin failed"
	doman ripmime.1 || die "doman failed"
	dodoc CHANGELOG INSTALL README TODO || die "dodoc failed"

	insinto /usr/include/ripmime
	doins mime.h ripmime-api.h || die "doins failed"

	dolib.so libripmime.so.1.4.0 || die "dolib.so failed"

	if use static-libs ; then
		dolib.a libripmime.a || die "dolib.a failed"
	fi
}
