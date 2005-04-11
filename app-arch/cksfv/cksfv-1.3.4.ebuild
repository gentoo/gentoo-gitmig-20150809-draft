# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.4.ebuild,v 1.1 2005/04/11 03:49:53 vapier Exp $

inherit eutils

DESCRIPTION="SFV checksum utility (simple file verification)"
HOMEPAGE="http://www.modeemi.fi/~shd/foss/cksfv/"
SRC_URI="http://www.modeemi.fi/~shd/foss/cksfv/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	dobin src/cksfv || die
	doman cksfv.1
	dodoc ChangeLog INSTALL README TODO
}
