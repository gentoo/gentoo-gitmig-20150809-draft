# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fstrim/fstrim-0.2.ebuild,v 1.1 2011/11/09 19:25:44 vapier Exp $

DESCRIPTION="discard (or 'trim') blocks which are not in use by the filesystem"
HOMEPAGE="http://sourceforge.net/projects/fstrim/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	rm -f "${S}"/Makefile
}

src_compile() {
	emake fstrim || die
}

src_install() {
	dosbin fstrim || die
}
