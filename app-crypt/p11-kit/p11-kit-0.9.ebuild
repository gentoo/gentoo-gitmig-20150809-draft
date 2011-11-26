# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/p11-kit/p11-kit-0.9.ebuild,v 1.2 2011/11/26 01:01:44 radhermit Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11."
HOMEPAGE="http://p11-glue.freedesktop.org/p11-kit.html"
SRC_URI="http://p11-glue.freedesktop.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="debug"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	econf \
		$(use_enable debug)
}
