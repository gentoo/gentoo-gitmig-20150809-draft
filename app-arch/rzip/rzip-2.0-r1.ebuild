# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rzip/rzip-2.0-r1.ebuild,v 1.7 2005/06/17 01:05:34 vapier Exp $

DESCRIPTION="compression program for large files"
HOMEPAGE="http://rzip.samba.org/"
SRC_URI="http://rzip.samba.org/ftp/rzip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="app-arch/bzip2"

src_install() {
	make \
		INSTALL_BIN="${D}"/usr/bin \
		INSTALL_MAN="${D}"/usr/share/man \
		install || die
	dosym rzip /usr/bin/runzip
}
