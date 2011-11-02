# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/redis/redis-2.2.8.ebuild,v 1.2 2011/11/02 21:40:35 vapier Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="A persistent caching system, key-value and data structures database."
HOMEPAGE="http://code.google.com/p/redis/"
SRC_URI="http://redis.googlecode.com/files/${PN}-${PV/_/-}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~x86-macos ~x86-solaris"
IUSE="tcmalloc test"
SLOT="0"

RDEPEND=""
DEPEND=">=sys-devel/autoconf-2.63
	tcmalloc? ( dev-util/google-perftools )
	test? ( dev-lang/tcl )
	${RDEPEND}"

S="${WORKDIR}/${PN}-${PV/_/-}"

REDIS_PIDDIR=/var/run/redis/
REDIS_PIDFILE=${REDIS_PIDDIR}/redis.pid
REDIS_DATAPATH=/var/lib/redis
REDIS_LOGPATH=/var/log/redis
REDIS_LOGFILE=${REDIS_LOGPATH}/redis.log

pkg_setup() {
	enewgroup redis 75
	enewuser redis 75 -1 ${REDIS_DATAPATH} redis
	# set tcmalloc-variable for the build as specified in
	# https://github.com/antirez/redis/blob/2.2/README. If build system gets
	# better integrated into autotools, replace with append-flags and
	# append-ldflags in src_configure()
	use tcmalloc && export EXTRA_EMAKE="${EXTRA_EMAKE} USE_TCMALLOC=yes"
}

src_prepare() {
	# now we will rewrite present Makefiles
	local makefiles=""
	for MKF in $(find -name 'Makefile' | cut -b 3-); do
		mv "${MKF}" "${MKF}.in"
		sed -i	-e 's:$(CC):@CC@:g' \
			-e 's:$(CFLAGS):@AM_CFLAGS@:g' \
			-e 's: $(DEBUG)::g' \
			-e 's:$(OBJARCH)::g' \
			-e 's:ARCH:TARCH:g' \
			-e '/^CCOPT=/s:$: $(LDFLAGS):g' \
			"${MKF}.in" \
		|| die "Sed failed for ${MKF}"
		makefiles+=" ${MKF}"
	done
	# autodetection of compiler and settings; generates the modified Makefiles
	cp "${FILESDIR}"/configure.ac-2.2 configure.ac
	sed -i	-e "s:AC_CONFIG_FILES(\[Makefile\]):AC_CONFIG_FILES([${makefiles}]):g" \
		configure.ac || die "Sed failed for configure.ac"
	eautoconf
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
	use prefix || fowners redis:redis /etc/redis.conf
	fperms 0644 /etc/redis.conf

	newconfd "${FILESDIR}/redis.confd" redis
	newinitd "${FILESDIR}/redis.initd" redis

	dodoc 00-RELEASENOTES BUGS Changelog CONTRIBUTING README TODO
	dodoc design-documents/*
	newdoc client-libraries/README README.client-libraries
	docinto html
	dodoc doc/*

	dobin src/redis-cli || die "redis-cli could not be found"
	dosbin src/redis-benchmark src/redis-server src/redis-check-aof src/redis-check-dump \
	|| die "some redis executables could not be found"
	fperms 0750 /usr/sbin/redis-benchmark

	if use prefix; then
	        diropts -m0750
	else
	        diropts -m0750 -o redis -g redis
	fi
	keepdir ${REDIS_DATAPATH} ${REDIS_LOGPATH} ${REDIS_PIDDIR}
}

pkg_postinst() {
	einfo "New features of Redis you want to consider enabling in redis.conf:"
	einfo " * unix sockets (using this is highly recommended)"
	einfo " * logging to syslog"
	einfo " * VM aka redis' own swap mechanism"
}
