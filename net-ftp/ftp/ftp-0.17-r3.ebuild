# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r3.ebuild,v 1.10 2003/12/17 04:24:36 brad_mssw Exp $

IUSE="ssl"

inherit eutils

MY_P=netkit-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Standard Linux FTP client with optional SSL support"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc ~alpha hppa mips ~arm amd64 ia64 ppc64"

RDEPEND=">=sys-libs/ncurses-5.2
	ssl? ( dev-libs/openssl )"

DEPEND=">=sys-apps/sed-4
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ "`use ssl`" ]; then
		epatch ${FILESDIR}/${MY_P}+ssl-0.2.diff
		epatch ${FILESDIR}/${MY_P}+ssl-0.2+auth.diff
	fi
}

src_compile() {
	./configure --prefix=/usr || die
	sed -i "s:-pipe -O2:${CFLAGS}:" MCONFIG
	emake || die
}

src_install() {
	into /usr
	dobin ftp/ftp
	doman ftp/ftp.1 ftp/netrc.5
	dodoc ChangeLog README BUGS
}
