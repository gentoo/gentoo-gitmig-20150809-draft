# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/netkit-ftpd/netkit-ftpd-0.17-r4.ebuild,v 1.2 2007/05/06 10:59:35 genone Exp $

inherit eutils ssl-cert

MY_P="linux-ftpd-${PV}"
DESCRIPTION="The netkit FTP server with optional SSL support"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-ssl.patch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}
	virtual/inetd"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	use ssl && epatch "${DISTDIR}"/${MY_P}-ssl.patch
	epatch "${FILESDIR}"/${P}-shadowfix.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-setguid.patch
}

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	sed -i -e "s:-pipe -O2:${CFLAGS}:" MCONFIG
	emake || die "parallel make failed"
}

src_install() {
	dobin ftpd/ftpd || die
	doman ftpd/ftpd.8
	dodoc README ChangeLog
	insinto /etc/xinetd.d
	newins "${FILESDIR}"/ftp.xinetd ftp
	if use ssl ; then
		insinto /etc/ssl/certs
		docert ftpd
	fi
}

pkg_postinst() {
	if use ssl ; then
		elog "In order to start the server with SSL support"
		elog "You need a certificate /etc/ssl/certs/ftpd.pem."
		elog "A temporary certificiate has been created."
	fi
}
