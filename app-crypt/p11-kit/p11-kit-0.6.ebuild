# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/p11-kit/p11-kit-0.6.ebuild,v 1.1 2011/09/18 07:21:04 scarabeus Exp $

EAPI=4

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11."
HOMEPAGE="http://p11-glue.freedesktop.org/p11-kit.html"
SRC_URI="http://p11-glue.freedesktop.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable debug)
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
