# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/lighttpd/lighttpd-1.1.8.ebuild,v 1.1 2004/04/23 17:30:26 stuart Exp $

DESCRIPTION="lighttpd is intented to be a frontend for ad-servers which have to deliver small files concurrently to many connections."
HOMEPAGE="http://jan.kneschke.de/projects/lighttpd"
SRC_URI="http://jan.kneschke.de/projects/lighttpd/download/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql ssl"
DEPEND="virtual/glibc
		>=dev-libs/libpcre-3.1
		>=sys-libs/zlib-1.1
		>=sys-devel/libtool-1.4"
RDEPEND=">=sys-libs/zlib-1.1
		 >=sys-devel/libtool-1.4"
S=${WORKDIR}/${P}
LIGHTTPD_DIR="/home/lighttpd"

pkg_setup() {
	if ! grep -q ^lighttpd: /etc/passwd ; then
		useradd  -g nofiles -s /bin/false -d ${LIGHTTPD_DIR} \
			-c "lighttpd" lighttpd || die "problem adding user lighttpd"
	fi
}

src_compile() {
	epatch ${FILESDIR}/lighttpd-1.1.8-gentoo.diff
	if [ `use ssl` ]; then
		USE_SSL="--with-openssl"
	fi
	econf \
		`use_with mysql` \
		${USE_SSL} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc README COPYING
	newdoc doc/lighttpd.conf lighttpd.conf.example
	dodoc doc/fastcgi.txt doc/authentification.txt
	insinto /etc/conf.d/;  doins doc/lighttpd.conf
	exeinto /etc/init.d;   newexe ${FILESDIR}/lighttpd.initd lighttpd
	dodir ${LIGHTTPD_DIR} ${LIGHTTPD_DIR}/logs
	chown lighttpd:root ${D}/${LIGHTTPD_DIR} ${D}/${LIGHTTPD_DIR}/logs
}
