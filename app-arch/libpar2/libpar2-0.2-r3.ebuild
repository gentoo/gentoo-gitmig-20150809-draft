# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libpar2/libpar2-0.2-r3.ebuild,v 1.1 2011/11/26 18:55:50 radhermit Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="A library for par2, extracted from par2cmdline"
HOMEPAGE="http://parchive.sourceforge.net/"
SRC_URI="mirror://sourceforge/parchive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-bugfixes.patch )

DOCS=( AUTHORS ChangeLog README )

AUTOTOOLS_IN_SOURCE_BUILD=1
