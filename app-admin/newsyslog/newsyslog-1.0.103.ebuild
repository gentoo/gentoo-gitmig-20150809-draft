# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/newsyslog/newsyslog-1.0.103.ebuild,v 1.4 2003/06/29 15:24:07 aliz Exp $

DESCRIPTION="An enhanced version of newsyslog originally written by Theodore Ts'o"
HOMEPAGE="http://www.weird.com/~woods/projects/newsyslog.html"
SRC_URI="ftp://ftp.weird.com/pub/local/newsyslog.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-apps/groff"
RDEPEND="virtual/cron 
	sys-apps/gzip"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/newsyslog-html.patch || die
}

src_compile() {
	myconf="--with-syslogd_pid=/var/run/syslog.pid"

	pkglist | grep -q syslog-ng \
	    && myconf="--with-syslogd_pid=/var/run/syslog-ng.pid"

	econf \
	    --with-gzip \
	    --with-newsyslog_conf=/etc/newsyslog.conf \
	    ${myconf}

	emake || die
}

src_install() {
	einstall catmandir=${D}/usr/share/man

	rm -rf ${D}/usr/share/man/cat?

	dodoc newsyslog.conf AUTHORS COPYING ChangeLog INSTALL NEWS README.* ToDo
	prepalldocs
}
