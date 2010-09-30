# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/posh/posh-0.8.6.ebuild,v 1.1 2010/09/30 13:11:42 xmw Exp $

EAPI=2

DESCRIPTION="Reimplementation of Bourne shell based on pdksh"
HOMEPAGE="http://packages.debian.org/posh"
SRC_URI="mirror://debian/pool/main/p/posh/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_configure() {
	econf --exec-prefix=/
}

src_install() {
	emake DESTDIR="${D}" install || die
}
