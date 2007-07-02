# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dbhub/dbhub-0.441.ebuild,v 1.1 2007/07/02 18:17:10 armin76 Exp $

inherit eutils

DESCRIPTION="Hub software for Direct Connect, fork of opendchub"
HOMEPAGE="http://dbhub.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="perl nls"

DEPEND="perl? ( dev-lang/perl )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/dbhub-gentoo.patch
}

src_compile() {
	econf  \
		$(use_enable nls lang) \
		$(use_enable perl) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
