# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/monkeyd/monkeyd-0.6.3.ebuild,v 1.1 2003/04/16 16:57:42 vapier Exp $

MY_P="${PN/d}-${PV}"
DESCRIPTION="fast, efficient, (REALLY) small, and easy to configure web server"
SRC_URI="http://monkeyd.sourceforge.net/versions/${MY_P}.tar.gz"
HOMEPAGE="http://monkeyd.sourceforge.net/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

S=${WORKDIR}/${MY_P}

src_compile() {
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--cgibin=/home/httpd/cgi-bin \
		--sysconfdir=/etc/${PN} \
		--datadir=/home/httpd/htdocs \
		--logdir=/var/log/${PN} \
		--lang=en \
		|| die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make \
		PREFIX=${D}/usr \
		BINDIR=${D}/usr/bin \
		CGIBIN=${D}/home/httpd/cgi-bin \
		SYSCONFDIR=${D}/etc/${PN} \
		DATADIR=${D}/home/httpd/htdocs \
		LOGDIR=${D}/var/log/${PN} \
		install \
		|| die
	dodoc CREDITOS HowItWorks.txt README ChangeLog NEWS
}
