# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpd/ftpd-0.17.ebuild,v 1.3 2003/01/16 02:02:27 raker Exp $

DESCRIPTION="The netkit FTP server with optional SSL support"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/linux-${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/linux-${P}

src_unpack() {

	unpack ${A}
	cd ${S}

	if [ "`use ssl`" ]; then
		zcat ${FILESDIR}/ssl.diff.gz | patch -p1 \
			|| die "ssl patch failed"
	fi

}

src_compile() {

	./configure --prefix=/usr || die "configure failed"

	cp MCONFIG MCONFIG.orig                                                 
        sed -e "s/-pipe -O2/${CFLAGS}/" MCONFIG.orig > MCONFIG

	emake || die "parallel make failed"

}

src_install() {

	dobin ftpd/ftpd
	doman ftpd/ftpd.8
	dodoc README ChangeLog

}

pkg_postinst() {

	einfo "In order to start the server with SSL support"
	einfo "You need to create a certificate and place it"
	einfo "in SSLCERTDIR..."
	einfo "<=openssl-0.9.6g - SSLCERTDIR=/usr/lib/ssl/certs"
	einfo ">=openssl-0.9.6g-r1 - SSLCERTDIR=/etc/ssl/certs"
	einfo ""
	einfo "cd SSLCERTDIR"
	einfo "openssl req -new -x509 -nodes -out ftpd.pem -keyout ftpd.pem"
	einfo ""

}
