# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/monkeyd/monkeyd-0.8.0.ebuild,v 1.2 2003/12/26 06:06:41 vapier Exp $

WEBROOT=/var/www/localhost

MY_P="${PN/d}-${PV}"
DESCRIPTION="fast, efficient, (REALLY) small, and easy to configure web server"
HOMEPAGE="http://monkeyd.sourceforge.net/"
SRC_URI="http://monkeyd.sourceforge.net/versions/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

S=${WORKDIR}/${MY_P}

src_compile() {
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--cgibin=${WEBROOT}/cgi-bin \
		--sysconfdir=/etc/${PN} \
		--datadir=${WEBROOT}/htdocs \
		--logdir=/var/log/${PN} \
		--lang=en \
		|| die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make \
		PREFIX=${D}/usr \
		BINDIR=${D}/usr/bin \
		CGIBIN=${D}${WEBROOT}/cgi-bin \
		SYSCONFDIR=${D}/etc/${PN} \
		DATADIR=${D}${WEBROOT}/htdocs \
		LOGDIR=${D}/var/log/${PN} \
		install \
		|| die
	[ -e ${ROOT}/${WEBROOT}/htdocs/index.html ] && mv ${D}${WEBROOT}/htdocs/{index,index-monkey}.html
	dosed "s:/var/log/monkeyd/monkey.pid:/var/run/monkey.pid:" /etc/monkeyd/monkey.conf
	exeinto /etc/init.d ; newexe ${FILESDIR}/monkeyd.init.d monkeyd
	insinto /etc/conf.d ; newins ${FILESDIR}/monkeyd.conf.d monkeyd
	dodoc MODULES HowItWorks.txt README ChangeLog
}
