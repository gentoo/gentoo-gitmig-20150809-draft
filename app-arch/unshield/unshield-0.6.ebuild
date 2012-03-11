# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unshield/unshield-0.6.ebuild,v 1.4 2012/03/11 15:41:53 ago Exp $

EAPI=2

DESCRIPTION="InstallShield CAB file extractor"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~x86"
IUSE="static-libs"

RDEPEND=">=sys-libs/zlib-1.1.4"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README

	find "${D}" -name '*.la' -exec rm -f {} +
}
