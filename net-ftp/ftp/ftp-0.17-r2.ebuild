# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r2.ebuild,v 1.4 2002/12/15 10:44:20 bjb Exp $

MY_P=netkit-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Standard Linux FTP client with optional SSL support"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	ssl? ( dev-libs/openssl )"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {
	unpack ${A}
	cd ${S}
	
	if [ "`use ssl`" ]; then
	    patch -p1 < ${FILESDIR}/${MY_P}+ssl-0.2.diff || die "ssl patch failed"
        fi
}

src_compile() {			  
	./configure --prefix=/usr || die
	cp MCONFIG MCONFIG.orig
	sed -e "s/-pipe -O2/${CFLAGS}/" MCONFIG.orig > MCONFIG
	emake || die
}

src_install() {							   
	into /usr
	dobin ftp/ftp
	doman ftp/ftp.1 ftp/netrc.5
	dodoc ChangeLog README BUGS
}
