# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/newsyslog/newsyslog-1.1.ebuild,v 1.14 2004/11/17 16:29:57 vapier Exp $

inherit eutils

DESCRIPTION="An enhanced version of newsyslog originally written by Theodore Ts'o"
HOMEPAGE="http://www.weird.com/~woods/projects/newsyslog.html"
SRC_URI="ftp://ftp.weird.com/pub/local/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha hppa ~mips ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="sys-apps/groff"
RDEPEND="virtual/cron
	app-arch/gzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/newsyslog-html.patch
}

src_compile() {
	local myconf="--with-syslogd_pid=/var/run/syslog.pid"

	has_version 'app-admin/syslog-ng' \
	    && myconf="--with-syslogd_pid=/var/run/syslog-ng.pid"

	econf \
	    --with-gzip \
	    --with-newsyslog_conf=/etc/newsyslog.conf \
	    ${myconf} || die "econf failed"

	emake || die
}

src_install() {
	make \
		DESTDIR="${D}" \
		catmandir=${D}/usr/share/man \
		install || die "install failed"
	dodoc newsyslog.conf AUTHORS ChangeLog INSTALL NEWS README.* ToDo
	prepalldocs
}
