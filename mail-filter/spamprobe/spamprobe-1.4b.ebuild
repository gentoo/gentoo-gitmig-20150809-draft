# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamprobe/spamprobe-1.4b.ebuild,v 1.5 2008/04/28 16:44:38 ticho Exp $

inherit eutils

DESCRIPTION="Fast, intelligent, automatic spam detector using Bayesian analysis."
HOMEPAGE="http://spamprobe.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE="berkdb"
DEPEND="berkdb? ( >=sys-libs/db-3.2 )"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodoc README.txt ChangeLog LICENSE.txt
	make DESTDIR="${D}" install || die

	insinto /usr/share/${PN}/contrib
	doins contrib/*
}
