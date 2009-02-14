# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamprobe/spamprobe-1.4d.ebuild,v 1.4 2009/02/14 23:41:46 maekke Exp $

inherit eutils

DESCRIPTION="Fast, intelligent, automatic spam detector using Bayesian analysis."
HOMEPAGE="http://spamprobe.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

IUSE="berkdb gif jpeg png"
DEPEND="berkdb? ( >=sys-libs/db-3.2 )
		gif? ( media-libs/giflib )
		jpeg? ( media-libs/jpeg )
		png? ( media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.4b-gcc43.patch
}

src_compile() {
	econf \
		$(use_with gif) \
		$(use_with jpeg) \
		$(use_with png) \
			|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodoc README.txt ChangeLog LICENSE.txt
	emake DESTDIR="${D}" install || die

	insinto /usr/share/${PN}/contrib
	doins contrib/*
}
