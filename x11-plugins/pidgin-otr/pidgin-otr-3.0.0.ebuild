# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-otr/pidgin-otr-3.0.0.ebuild,v 1.3 2007/08/22 13:31:46 gustavoz Exp $

inherit flag-o-matic eutils autotools

MY_P=${P/pidgin/gaim}
DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${MY_P}.tar.gz
	http://www.cypherpunks.ca/otr/gaim2b2-otr.diff
	http://dev.gentoo.org/~drizzt/trash/${P}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libotr-3.0.0
	net-im/pidgin"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}"/gaim2b2-otr.diff
	epatch "${WORKDIR}"/${P}.patch

	eautoreconf
}

src_compile() {
	strip-flags
	replace-flags -O? -O2

	econf || die "econf failed"
	emake -j1 || die "Make failed"
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "Install failed"
	dodoc COPYING ChangeLog README
}
