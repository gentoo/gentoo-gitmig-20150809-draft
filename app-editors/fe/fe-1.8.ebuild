# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fe/fe-1.8.ebuild,v 1.3 2008/01/09 13:00:45 ulm Exp $

inherit eutils

DESCRIPTION="A small and easy to use folding editor"
HOMEPAGE="http://www.moria.de/~michael/fe/"
SRC_URI="http://www.moria.de/~michael/fe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sendmail"

DEPEND="sys-libs/ncurses
	sendmail? ( virtual/mta )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.6-nostrip.patch"
}

src_compile() {
	econf $(use_enable sendmail) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake \
		prefix="${D}"/usr \
		datadir="${D}"/usr/share \
		MANDIR="${D}"/usr/share/man \
		install || die "emake install failed"

	dodoc NEWS README || die "dodoc failed"
	dohtml fe.html || die "dohtml failed"
}
