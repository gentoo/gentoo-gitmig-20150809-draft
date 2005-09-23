# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rzip/rzip-2.0-r2.ebuild,v 1.2 2005/09/23 15:55:45 grobian Exp $

inherit autotools

DESCRIPTION="compression program for large files"
HOMEPAGE="http://rzip.samba.org/"
SRC_URI="http://rzip.samba.org/ftp/rzip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="app-arch/bzip2
	>=sys-devel/autoconf-2.59"
RDEPEND="app-arch/bzip2"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-darwin.patch"
	cd ${S}
	WANT_AUTOCONF="2.5" eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "failed installing"
	dosym rzip /usr/bin/runzip || die "failed creating runzip symlink"
}
