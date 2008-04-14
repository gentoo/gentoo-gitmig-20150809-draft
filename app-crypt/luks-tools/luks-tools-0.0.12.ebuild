# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/luks-tools/luks-tools-0.0.12.ebuild,v 1.3 2008/04/14 18:42:19 cardoe Exp $

DESCRIPTION="GUI frontend for dm-crypt/luks."
HOMEPAGE="http://www.flyn.org/projects/luks-tools/"
SRC_URI="http://www.flyn.org/projects/luks-tools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-fs/cryptsetup-1.0.5
	>=dev-python/pygtk-2.8.0
	>=sys-apps/hal-0.5"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS FAQ NEWS README TODO
}
