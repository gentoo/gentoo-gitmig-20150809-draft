# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r3.ebuild,v 1.15 2005/02/12 00:18:41 vapier Exp $

inherit eutils

MY_P=netkit-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Standard Linux FTP client with optional SSL support"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
IUSE="ssl"

RDEPEND=">=sys-libs/ncurses-5.2
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	use ssl \
		&& epatch ${FILESDIR}/${MY_P}+ssl-0.2.diff \
		&& epatch ${FILESDIR}/${MY_P}+ssl-0.2+auth.diff
}

src_compile() {
	./configure --prefix=/usr || die
	sed -i "s:-pipe -O2:${CFLAGS}:" MCONFIG
	emake || die
}

src_install() {
	dobin ftp/ftp || die
	doman ftp/ftp.1 ftp/netrc.5
	dodoc ChangeLog README BUGS
}
