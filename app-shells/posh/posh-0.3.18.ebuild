# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/posh/posh-0.3.18.ebuild,v 1.2 2005/07/16 15:09:39 swegener Exp $

DESCRIPTION="stripped-down version of pdksh"
HOMEPAGE="http://packages.debian.org/posh/"
SRC_URI="mirror://debian/pool/main/p/posh/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR=${D} bindir=/bin install || die
}
