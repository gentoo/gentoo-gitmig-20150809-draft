# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/newsyslog/newsyslog-1.1.ebuild,v 1.13 2004/11/03 16:30:14 corsair Exp $

inherit eutils

DESCRIPTION="An enhanced version of newsyslog originally written by Theodore Ts'o"
HOMEPAGE="http://www.weird.com/~woods/projects/newsyslog.html"
SRC_URI="ftp://ftp.weird.com/pub/local/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips alpha hppa ~ppc64"
IUSE=""

DEPEND="sys-apps/groff"
RDEPEND="virtual/cron
	app-arch/gzip"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/newsyslog-html.patch
}

src_compile() {
	myconf="--with-syslogd_pid=/var/run/syslog.pid"

	has_version 'app-admin/syslog-ng' \
	    && myconf="--with-syslogd_pid=/var/run/syslog-ng.pid"

	econf \
	    --with-gzip \
	    --with-newsyslog_conf=/etc/newsyslog.conf \
	    ${myconf} || die "econf failed"

	emake || die
}

src_install() {
	einstall catmandir=${D}/usr/share/man

	rm -rf ${D}/usr/share/man/cat?

	dodoc newsyslog.conf AUTHORS ChangeLog INSTALL NEWS README.* ToDo
	prepalldocs
}
