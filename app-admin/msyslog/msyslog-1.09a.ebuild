# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/msyslog/msyslog-1.09a.ebuild,v 1.9 2003/05/15 00:19:13 kumba Exp $

#lame upstream conventions...
#archive:    msyslog-1.09a-src.tar.gz
#unpacks to: msyslog-v1.09a/

S=${WORKDIR}/${PN}-v${PV}
DESCRIPTION="Flexible and easy to integrate syslog with modularized input/output"
HOMEPAGE="http://sourceforge.net/projects/msyslog/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc ~ppc hppa ~mips"
IUSE="postgres mysql"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	mysql? ( >=dev-db/mysql-3.23 )
	postgres? ( >=dev-db/postgresql-7 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix paths for pidfile, config file, libdir, logdir...
	patch -p1 <${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	local myconf
	[ "${ARCH}" = "hppa" ] && CFLAGS="${CFLAGS} -fPIC"
	use mysql || myconf="${myconf} --without-mysql"
	use postgres || myconf="${myconf} --without-pgsql"
	econf --with-daemon-name=msyslogd ${myconf}
	emake || die
}

src_install() {
	into /usr
	dosbin src/msyslogd src/peo/peochk

	# be mindful here when upgrading...
	exeinto /usr/lib
	doexe src/modules/lib${PN}.so.${PV}
	( cd ${D}/usr/lib ; ln -s lib${PN}.so.${PV} lib${PN}.so )

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
	# empty dir...
	install -m0755 -o root -g root -d ${ROOT}/var/lib/msyslog
}
