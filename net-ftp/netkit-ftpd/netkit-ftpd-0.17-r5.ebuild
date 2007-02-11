# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/netkit-ftpd/netkit-ftpd-0.17-r5.ebuild,v 1.6 2007/02/11 12:48:58 blubb Exp $

inherit eutils ssl-cert

MY_P="linux-ftpd-${PV}"
DESCRIPTION="The netkit FTP server with optional SSL support"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-ssl.patch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~ia64 ppc ~s390 ~sh sparc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}
	virtual/inetd"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd "${S}"
	use ssl && epatch "${DISTDIR}"/${MY_P}-ssl.patch "${FILESDIR}"/${P}-cleanup-ssl.patch
	epatch "${FILESDIR}"/${P}-cleanup.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-shadowfix.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-setguid.patch
}

src_compile() {
	./configure --prefix=/usr || die "configure failed"
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
		einfo "In order to start the server with SSL support"
		einfo "You need a certificate /etc/ssl/certs/ftpd.pem."
		einfo "A temporary certificiate has been created."
	fi
}
