# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r1.ebuild,v 1.17 2004/02/20 17:00:56 agriffis Exp $

MY_P=netkit-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Standard Linux FTP client"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"

src_compile() {
	./configure --prefix=/usr || die
	cp MCONFIG MCONFIG.orig
	sed -e "s:-pipe -O2:${CFLAGS}:" MCONFIG.orig > MCONFIG
	make || die
}

src_install() {
	into /usr
	dobin ftp/ftp
	doman ftp/ftp.1 ftp/netrc.5
	dodoc ChangeLog README BUGS
}
