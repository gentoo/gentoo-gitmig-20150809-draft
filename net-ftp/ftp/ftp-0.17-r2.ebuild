# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r2.ebuild,v 1.9 2004/02/20 17:00:56 agriffis Exp $

inherit eutils

MY_P=netkit-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Standard Linux FTP client with optional SSL support"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"

DEPEND=">=sys-libs/ncurses-5.2
	ssl? ( dev-libs/openssl )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa mips"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ "`use ssl`" ]; then
		epatch ${FILESDIR}/${MY_P}+ssl-0.2.diff
	fi
}

src_compile() {
	./configure --prefix=/usr || die
	cp MCONFIG MCONFIG.orig
	sed -e "s:-pipe -O2:${CFLAGS}:" MCONFIG.orig > MCONFIG
	emake || die
}

src_install() {
	into /usr
	dobin ftp/ftp
	doman ftp/ftp.1 ftp/netrc.5
	dodoc ChangeLog README BUGS
}
