# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/msyslog/msyslog-1.08a-r2.ebuild,v 1.3 2002/07/17 20:43:17 drobbins Exp $

DESCRIPTION="Flexible and easy to integrate syslog with modularized input/output"
HOMEPAGE="http://www.core-sdi.com/download/download1.html"
SRC_URI="http://community.corest.com/pub/${PN}/${PN}-v${PV}.tgz"
SLOT="0"
S=${WORKDIR}/${PN}-v${PV}

RDEPEND="virtual/glibc mysql? ( >=dev-db/mysql-3.23 ) postgres? ( >=dev-db/postgresql-7 )"
DEPEND="virtual/glibc"
KEYWORDS="x86"
LICENSE="BSD"
SLOT="0"

src_unpack() {
	unpack ${A} ; cd ${S}
	# fix paths for pidfile, config file, libdir, logdir, manpages, etc...
	patch -p1 < ${FILESDIR}/${PN}-${PV}-gentoo.diff || die "bad patchfile"
}

src_compile() {
	local myconf
	use mysql || myconf="${myconf} --without-mysql"
	use postgres || myconf="${myconf} --without-pgsql"

	./configure \
		--prefix=/usr \
		--with-daemon-name=msyslogd \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	dodir /var/lib/msyslog
	dosbin src/msyslogd src/peo/peochk

	exeinto /usr/lib
	doexe src/modules/lib${PN}.so.${PV/a/}
	( cd ${D}/usr/lib ; ln -s lib${PN}.so.${PV/a/} lib${PN}.so )

	# rename these puppies...
	mv src/man/syslogd.8 src/man/msyslogd.8
	mv src/man/syslog.conf.5 src/man/msyslog.conf.5
	doman src/man/*.[85]

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS \
		QUICK_INSTALL README src/TODO doc/*
	docinto examples ; dodoc src/examples/*

	insinto /etc/msyslog ; doins ${FILESDIR}/msyslog.conf
	insinto /etc/conf.d ; newins ${FILESDIR}/msyslog-confd msyslog
	exeinto /etc/init.d ; newexe ${FILESDIR}/msyslog-init msyslog
}

pkg_postinst() {
	# the default /etc/msyslog/msyslog.conf uses these, so make sure
	# it 'just works' for those who wont bother changing the config.
	touch ${ROOT}/var/log/messages
	touch ${ROOT}/var/log/syslog
}
