# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/swarp/swarp-2.17.6.ebuild,v 1.1 2009/07/28 00:00:31 bicatali Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Resample and coadd astronomical FITS images"
HOMEPAGE="http://astromatic.iap.fr/software/swarp"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc threads"
RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-configure.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable threads)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog HISTORY README THANKS BUGS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/* || die
	fi
}
