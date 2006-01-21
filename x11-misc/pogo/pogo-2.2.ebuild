# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pogo/pogo-2.2.ebuild,v 1.10 2006/01/21 12:56:21 nelchael Exp $

IUSE=""

DESCRIPTION="Pogo is a neat launcher program for X"
SRC_URI="http://www.ibiblio.org/propaganda/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.ibiblio.org/propaganda/pogo/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )
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
