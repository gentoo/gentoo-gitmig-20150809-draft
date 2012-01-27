# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/posh/posh-0.10.1.ebuild,v 1.1 2012/01/27 13:55:13 mgorny Exp $

EAPI=3
inherit autotools-utils

DESCRIPTION="Reimplementation of Bourne shell based on pdksh"
HOMEPAGE="http://packages.debian.org/posh"
SRC_URI="mirror://debian/pool/main/p/posh/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_configure() {
	myeconfargs=(
		--exec-prefix=/
	)
	autotools-utils_src_configure
}
