# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamprobe/spamprobe-1.4d.ebuild,v 1.5 2010/03/08 17:34:40 ssuominen Exp $

EAPI=2
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
	jpeg? ( media-libs/jpeg:0 )
	png? ( media-libs/libpng )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4b-gcc43.patch \
		"${FILESDIR}"/${P}-libpng14.patch
}

src_configure() {
	econf \
		$(use_with gif) \
		$(use_with jpeg) \
		$(use_with png)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README.txt

	insinto /usr/share/${PN}/contrib
	doins contrib/* || die
}
