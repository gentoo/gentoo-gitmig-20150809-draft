# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgcluster/pgcluster-1.3.0c.ebuild,v 1.7 2007/02/10 23:49:28 dev-zero Exp $

inherit eutils gnuconfig flag-o-matic multilib

DESCRIPTION="the synchronous replication system of the multi-master composition for PostgreSQL"
HOMEPAGE="http://www.csra.co.jp/~mitani/jpug/pgcluster/en/"
MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}
SRC_URI="http://pgfoundry.org/frs/download.php/218/${P}.tar.gz"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE="doc libg++ nls pam perl pg-intdatetime python readline ssl tcl xml zlib"

S=${WORKDIR}/${MY_P}
DEPEND="virtual/libc
	sys-devel/autoconf
	>=sys-libs/ncurses-5.2
	>=sys-devel/bison-1.875
	zlib? ( >=sys-libs/zlib-1.1.3 )
	readline? ( >=sys-libs/readline-4.1 )
	tcl? ( >=dev-lang/tcl-8 )
	perl? ( >=dev-lang/perl-5.6.1-r2 )
	python? ( >=dev-lang/python-2.2 dev-python/egenix-mx-base )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	xml? ( dev-libs/libxml2 dev-libs/libxslt dev-util/pkgconfig )
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/libc
	zlib? ( >=sys-libs/zlib-1.1.3 )
	tcl? ( >=dev-lang/tcl-8 )
	perl? ( >=dev-lang/perl-5.6.1-r2 )
	python? ( >=dev-lang/python-2.2 )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	!dev-db/postgresql"

PG_DIR="/var/lib/postgresql"
MAX_CONNECTIONS=1024

pkg_setup() {
	if [ -f ${PG_DIR}/data/PG_VERSION ] ; then
		PG_MAJOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f1 -d.`
		PG_MINOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f2 -d.`
		if [ ${PG_MAJOR} -lt 8 ] || [ ${PG_MAJOR} -eq 8 -a ${PG_MINOR} -lt 0 ] ; then
			eerror "Postgres ${MY_PV} cannot upgrade your existing databases, you must"
			eerror "use pg_dump to export your existing databases to a file, and then"
			eerror "pg_restore to import them when you have upgraded completely."
			eerror "You must remove your entire database directory to continue."
			eerror "(database directory = ${PG_DIR})."
			exit 1
		fi
	fi
}

src_unpack() {
	unpack ${A} || die
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	filter-flags -ffast-math

	local myconf
	use tcl && myconf="--with-tcl"
	use python && myconf="$myconf --with-python"
	use perl && myconf="$myconf --with-perl"
	use ssl && myconf="$myconf --with-openssl"
	use nls && myconf="$myconf --enable-nls"
	use libg++ && myconf="$myconf --with-CXX"
	use pam && myconf="$myconf --with-pam"
	use readline || myconf="$myconf --without-readline"
	use zlib || myconf="$myconf --without-zlib"
	use pg-intdatetime && myconf="$myconf --enable-integer-datetimes"

	myconf="$myconf --enable-thread-safety"

	# these are the only working CFLAGS I could get on ppc, so locking them
	# down, anything more aggressive fails (i.e. -mcpu or -Ox)
	# Gerk - Nov 26, 2002
	use ppc && CFLAGS="-pipe -fsigned-char"

	# Detect mips systems properly
	gnuconfig_update

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--with-docdir=/usr/share/doc/${PF} \
		--libdir=/usr/$(get_libdir) \
		--enable-depend \
		--with-maxbackends=${MAX_CONNECTIONS} \
		--sysconfdir=/etc \
		$myconf || die

	make || die
	cd contrib
	make || die
	if use xml; then
		cd xml2
		make || die
	fi
}

src_install() {
	if use perl; then
		mv ${S}/src/pl/plperl/Makefile ${S}/src/pl/plperl/Makefile_orig
		sed -e "s:(INST_DYNAMIC) /usr/lib:(INST_DYNAMIC) ${D}/usr/lib:" \
			${S}/src/pl/plperl/Makefile_orig > ${S}/src/pl/plperl/Makefile
		mv ${S}/src/pl/plperl/GNUmakefile ${S}/src/pl/plperl/GNUmakefile_orig
		sed -e "s:\$(DESTDIR)\$(plperl_installdir):\$(plperl_installdir):" \
			${S}/src/pl/plperl/GNUmakefile_orig > ${S}/src/pl/plperl/GNUmakefile
	fi

	make DESTDIR=${D} LIBDIR=${D}/usr/lib install || die
#	make DESTDIR=${D} install-all-headers || die
	cd ${S}/contrib
	make DESTDIR=${D} LIBDIR=${D}/usr/lib install || die
	if use xml; then
		cd ${S}/contrib/xml2
		make DESTDIR=${D} LIBDIR=${D}/usr/lib install || die
	fi
	cd ${S}
#	if use pg-hier; then
#		dodoc ${WORKDIR}/README-${P_HIERPG}.html || die
#	fi
	dodoc README HISTORY COPYRIGHT INSTALL
	dodoc contrib/adddepend/*

	exeinto /usr/bin

	dodir /usr/include/postgresql/pgsql
	cp ${D}/usr/include/*.h ${D}/usr/include/postgresql/pgsql

	cd ${S}/doc
	dodoc FAQ* README.* TODO bug.template
	if use doc; then
		cd ${S}/doc
		docinto FAQ_html || die
		dodoc src/FAQ/* || die
		docinto sgml || die
		dodoc src/sgml/*.{sgml,dsl} || die
		docinto sgml/ref || die
		dodoc src/sgml/ref/*.sgml || die
		docinto TODO.detail || die
		dodoc TODO.detail/* || die
	fi

	mv ${D}/etc/pgcluster/pgreplicate.conf.sample \
	${D}/etc/pgcluster/pgreplicate.conf
	mv ${D}/etc/pgcluster/pglb.conf.sample \
	${D}/etc/pgcluster/pglb.conf

	cd ${S}
	exeinto /etc/init.d/
	newexe ${FILESDIR}/pgcluster.init-${PV} pgcluster || die
	newexe ${FILESDIR}/pglb.init-${PV} pglb || die
	newexe ${FILESDIR}/pgreplicate.init-${PV} pgreplicate || die
#	newexe ${FILESDIR}/pg_autovacuum.init-${PV} pg_autovacuum || die
	dosed "s:___DOCDIR___:/usr/share/doc/${PF}:" /etc/init.d/pg_autovacuum

	insinto /etc/conf.d/
	newins ${FILESDIR}/pgcluster.conf-${PV} pgcluster || die
	newins ${FILESDIR}/pglb.conf-${PV} pglb || die
	newins ${FILESDIR}/pgreplicate.conf-${PV} pgreplicate || die
#	newins ${FILESDIR}/pg_autovacuum.conf-${PV} pg_autovacuum || die

	keepdir $PG_DIR
	keepdir /var/log/pgcluster
	chown -Rf postgres:postgres ${D}/var/log/pgcluster

	keepdir /var/lib/pgcluster
	chown -Rf postgres:postgres ${D}/var/lib/pgcluster

	chown -Rf postgres:postgres ${D}/etc/pgcluster
}

pkg_postinst() {
	einfo "Make sure the postgres user in /etc/passwd has an account setup with /bin/bash as the shell"

	if [ ! -f ${PG_DIR}/data/PG_VERSION ] ; then
		einfo
		einfo "Execute the following command"
		einfo "emerge --config =${PF}"
		einfo "to setup the initial database environment."
	fi

	einfo
	einfo "Python modules was removed from PostgreSQL package."
	einfo "If you need it, please run \"emerge dev-db/pygresql\"."
	einfo
}

pkg_config() {
	einfo "Creating the data directory ..."
	mkdir -p ${PG_DIR}/data
	chown -Rf postgres:postgres ${PG_DIR}
	chmod 700 ${PG_DIR}/data

	einfo "Initializing the database ..."
	if [ -f ${PG_DIR}/data/PG_VERSION ] ; then
		eerror "Pgcluster ${MY_PV} cannot upgrade your existing databases."
		eerror "You must remove your entire database directory to continue."
		eerror "(database directory = ${PG_DIR})."
		exit 1
	else
		local SEM=`sysctl -n kernel.sem | cut -f-3`
		local SEMMNI=`sysctl -n kernel.sem | cut -f4`
		local SEMMNI_MIN=`expr \( ${MAX_CONNECTIONS} + 15 \) / 16`
		local SHMMAX=`sysctl -n kernel.shmmax`
		local SHMMAX_MIN=134217728 # 128M

		if [ ${SEMMNI} -lt ${SEMMNI_MIN} ]; then
			eerror "The current value of SEMMNI is too low"
			eerror "for postgresql to run ${MAX_CONNECTIONS} connections"
			eerror "Temporary setting this value to ${SEMMNI_MIN} while creating the initial database."
			echo ${SEM} ${SEMMNI_MIN} > /proc/sys/kernel/sem
		fi
		su postgres -c "/usr/bin/initdb --pgdata ${PG_DIR}/data"

		if [ ! `sysctl -n kernel.sem | cut -f4` -eq ${SEMMNI} ] ; then
			echo ${SEM} ${SEMMNI} > /proc/sys/kernel/sem
			ewarn "Restoring the SEMMNI value to the previous value"
			ewarn "Please edit the last value of kernel.sem in /etc/sysctl.conf"
			ewarn "and set it to at least ${SEMMNI_MIN}"
			ewarn
			ewarn "  kernel.sem = ${SEM} ${SEMMNI_MIN}"
			ewarn
		fi

		if [ ${SHMMAX} -lt ${SHMMAX_MIN} ]; then
			eerror "The current value of SHMMAX is too low for postgresql to run."
			eerror "Please edit /etc/sysctl.conf and set this value to at least ${SHMMAX_MIN}."
			eerror
			eerror "  kernel.shmmax = ${SHMMAX_MIN}"
			eerror

		fi
	fi
}
