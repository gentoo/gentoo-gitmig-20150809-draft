# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pogo/pogo-2.2.ebuild,v 1.13 2007/07/22 03:56:37 dberkholz Exp $

IUSE=""

DESCRIPTION="Pogo is a neat launcher program for X"

SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://m80.dyndns.org/propaganda/pogo/index.shtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	media-libs/imlib
	media-libs/jpeg
	>=sys-apps/sed-4"

src_compile() {
	cp ${FILESDIR}/Makefile .
	make clean || die "Clean failed"
	for file in `grep -r /usr/local/ *|cut -f1 -d":"|sort|uniq`;do
		sed -i -e "s:/usr/local:/usr/share:g" ${file}
	done
	make all || die "Make failed"
}

src_install () {
	dodoc README
	make DESTDIR="${D}" install || die "Install failed"
}
