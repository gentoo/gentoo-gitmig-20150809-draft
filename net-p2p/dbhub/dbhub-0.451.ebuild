# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dbhub/dbhub-0.451.ebuild,v 1.2 2008/06/30 12:52:45 corsair Exp $

inherit eutils

DESCRIPTION="Hub software for Direct Connect, fork of opendchub"
HOMEPAGE="http://www.dbhub.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug perl nls switch_user"

DEPEND="perl? ( dev-lang/perl )
		switch_user? ( sys-libs/libcap )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-gentoo.patch
}

src_compile() {
	econf  \
		$(use_enable nls) \
		$(use_enable perl) \
		$(use_enable switch_user) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
