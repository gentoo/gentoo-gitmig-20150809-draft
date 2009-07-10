# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnipper/libnipper-0.12.6-r1.ebuild,v 1.1 2009/07/10 06:31:16 ikelos Exp $

inherit eutils cmake-utils

DESCRIPTION="A router configuration security analysis library"
HOMEPAGE="http://nipper.titania.co.uk/"
SRC_URI="mirror://sourceforge/nipper/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# DEPEND is implicitly set by cmake-utils
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-glibc-2.10.patch"
}
