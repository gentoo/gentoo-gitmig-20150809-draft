# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.1.1.ebuild,v 1.6 2004/11/02 21:56:19 motaboy Exp $

inherit kde flag-o-matic eutils

DESCRIPTION="A KDE 3.x FTP Manager"
SRC_URI="mirror://sourceforge/kbear/${P}-1.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net/"

SLOT="0"
IUSE=""

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~amd64"
S=${WORKDIR}/kbear-2.1

need-kde 3

src_unpack() {
	use amd64 && append-flags -fPIC
	kde_src_unpack
	cd ${S}
	useq arts || epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-gcc-3.4.patch
}

