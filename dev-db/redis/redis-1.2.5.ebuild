# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/redis/redis-1.2.5.ebuild,v 1.2 2010/03/25 07:36:36 robbat2 Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="Persistent distributed key-value data caching system."
HOMEPAGE="http://code.google.com/p/redis/"
SRC_URI="http://redis.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

RDEPEND=""
DEPEND=""

REDIS_PIDDIR=/var/run/redis/
REDIS_PIDFILE=${REDIS_PIDDIR}/redis.pid
REDIS_DATAPATH=/var/lib/redis
REDIS_LOGPATH=/var/log/redis
REDIS_LOGFILE=${LOGPATH}/redis.log

pkg_setup() {
	enewgroup redis 75 || die "problem adding 'redis' group"
	enewuser redis 75 -1 ${REDIS_DATAPATH} redis || die "problem adding 'redis' user"
}

src_prepare() {
	# Borrowed from debian
	epatch "${FILESDIR}"/01-dont-print-pid-on-startup.diff
	# Now autotoolize this
	cp "${FILESDIR}"/configure.ac-1.02 configure.ac
	mv Makefile Makefile.in
	sed -i \
		-e 's:$(CC):@CC@:g' \
		-e 's:$(CFLAGS):@AM_CFLAGS@:g' \
		-e 's: $(DEBUG)::g' \
		-e 's:ARCH:GCC_ARCH_FLAG:g' \
		-e 's:PROF:GCC_PROF_FLAG:g' \
		Makefile.in \
	|| die "sed failed!"

	eautoreconf
}

src_install() {
	# configuration file rewrites
	insinto /etc/
	sed -r \
		-e "/^pidfile\>/s,/var.*,${REDIS_PIDFILE}," \
		-e '/^daemonize\>/s,no,yes,' \
		-e '/^# bind/s,^# ,,' \
		-e '/^# maxmemory\>/s,^# ,,' \
		-e '/^maxmemory\>/s,<bytes>,67108864,' \
		-e "/^dbfilename\>/s,dump.rdb,${REDIS_DATAPATH}/dump.rdb," \
		-e "/^dir\>/s, .*, ${REDIS_DATAPATH}/," \
		-e '/^loglevel\>/s:debug:notice:' \
		-e "/^logfile\>/s:stdout:${REDIS_LOGFILE}:" \
		<redis.conf \
		>redis.conf.gentoo
	newins redis.conf.gentoo redis.conf
	fowners root:redis /etc/redis.conf
	fperms 0640 /etc/redis.conf

	newconfd "${FILESDIR}/redis.confd" redis
	newinitd "${FILESDIR}/redis.initd" redis

	dodoc 00-RELEASENOTES BETATESTING.txt BUGS Changelog README TODO
	newdoc client-libraries/README README.client-libraries
	dohtml doc/*

	dobin redis-benchmark redis-cli
	dosbin redis-server

	diropts -m0750 -o redis -g redis
	keepdir ${REDIS_DATAPATH} ${REDIS_LOGFILE} ${REDIS_PIDDIR}
}
