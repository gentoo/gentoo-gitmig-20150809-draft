# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.3.15-r1.ebuild,v 1.7 2006/08/11 02:51:49 weeve Exp $

inherit eutils gnuconfig flag-o-matic java-pkg multilib

DESCRIPTION="sophisticated Object-Relational DBMS"

HOMEPAGE="http://www.postgresql.org/"
SRC_URI="mirror://postgresql/source/v${PV}/${PN}-base-${PV}.tar.bz2
	mirror://postgresql/source/v${PV}/${PN}-opt-${PV}.tar.bz2
	doc? ( mirror://postgresql/source/v${PV}/${PN}-docs-${PV}.tar.bz2 )"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 mips ppc ~s390 ~sh sparc ~x86"
IUSE="doc java libg++ nls pam perl python readline ssl tcl tk zlib threads selinux"

DEPEND="virtual/libc
	=dev-db/libpq-7.3.15*
	sys-devel/autoconf
	>=sys-libs/ncurses-5.2
	zlib? ( >=sys-libs/zlib-1.1.3 )
	readline? ( >=sys-libs/readline-4.1 )
	tcl? ( >=dev-lang/tcl-8 )
	tk? ( >=dev-lang/tk-8.3.3-r1 )
	perl? ( >=dev-lang/perl-5.6.1-r2 )
	python? ( >=dev-lang/python-2.2 dev-python/egenix-mx-base )
	java? ( >=virtual/jdk-1.3 >=dev-java/ant-1.3
		dev-java/java-config )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	nls? ( sys-devel/gettext )"
# java dep workaround for portage bug
# x86? ( java? ( =dev-java/sun-jdk-1.3* >=dev-java/ant-1.3 ) )
RDEPEND="virtual/libc
	=dev-db/libpq-7.3.15*
	zlib? ( >=sys-libs/zlib-1.1.3 )
	tcl? ( >=dev-lang/tcl-8 )
	perl? ( >=dev-lang/perl-5.6.1-r2 )
	python? ( >=dev-lang/python-2.2 )
	java? ( >=virtual/jdk-1.3 )
	selinux? ( sec-policy/selinux-postgresql )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )"

PG_DIR="/var/lib/postgresql"

pkg_setup() {
	if [ -f ${PG_DIR}/data/PG_VERSION ] ; then
		PG_MAJOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f1 -d.`
		PG_MINOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f2 -d.`
		if [ ${PG_MAJOR} -lt 7 ] || [ ${PG_MAJOR} -eq 7 -a ${PG_MINOR} -lt 3 ] ; then
			eerror "Postgres ${PV} cannot upgrade your existing databases, you must"
			eerror "use pg_dump to export your existing databases to a file, and then"
			eerror "pg_restore to import them when you have upgraded completely."
			eerror "You must remove your entire database directory to continue."
			eerror "(database directory = ${PG_DIR})."
			exit 1
		fi
	fi
	enewgroup postgres 70 \
		|| die "problem adding group postgres"
	enewuser postgres 70 /bin/bash /var/lib/postgresql postgres \
		|| die "problem adding user postgres"
}

check_java_config() {
	JDKHOME="`java-config --jdk-home`"
	if [[ -z "${JDKHOME}" || ! -d "${JDKHOME}" ]]; then
		NOJDKERROR="You need to use java-config to set your JVM to a JDK!"
		eerror "${NOJDKERROR}"
		die "${NOJDKERROR}"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-${PV%.*}-gentoo.patch"
	epatch "${FILESDIR}/${PN}-${PV%.*}-cubeparse.patch"
}

src_compile() {
	filter-flags -ffast-math

	if use java; then
		check_java_config
	fi

	local myconf
	use tcl && myconf="--with-tcl"
	use python && myconf="$myconf --with-python"
	use perl && myconf="$myconf --with-perl"
	use java && myconf="$myconf --with-java"
	use ssl && myconf="$myconf --with-openssl"
	use nls && myconf="$myconf --enable-nls"
	use libg++ && myconf="$myconf --with-CXX"
	use pam && myconf="$myconf --with-pam"
	use readline || myconf="$myconf --without-readline"
	use zlib || myconf="$myconf --without-zlib"
	use threads && myconf="$myconf --enable-thread-safety"

	# these are the only working CFLAGS I could get on ppc, so locking them
	# down, anything more aggressive fails (i.e. -mcpu or -Ox)
	# Gerk - Nov 26, 2002
	use ppc && CFLAGS="-pipe -fsigned-char"

	# Detect mips systems properly
	gnuconfig_update

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--docdir=/usr/share/doc/${PF} \
		--libdir=/usr/$(get_libdir) \
		--includedir=/usr/include/postgresql/pgsql \
		--enable-depend \
		--with-maxbackends=1024 \
		$myconf || die

	make || die
	cd contrib
	make || die
}

src_install() {
	if use perl; then
		mv ${S}/src/pl/plperl/Makefile ${S}/src/pl/plperl/Makefile_orig
		sed -e "s:(INST_DYNAMIC) /usr/lib:(INST_DYNAMIC) ${D}/usr/$(get_libdir):" \
			${S}/src/pl/plperl/Makefile_orig > ${S}/src/pl/plperl/Makefile
		mv ${S}/src/pl/plperl/GNUmakefile ${S}/src/pl/plperl/GNUmakefile_orig
		sed -e "s:\$(DESTDIR)\$(plperl_installdir):\$(plperl_installdir):" \
			${S}/src/pl/plperl/GNUmakefile_orig > ${S}/src/pl/plperl/GNUmakefile
	fi

	make DESTDIR=${D} includedir_server=/usr/include/postgresql/server \
		includedir_internal=/usr/include/postgresql/internal \
		LIBDIR=${D}/usr/$(get_libdir) \
		python_moduleexecdir="${python_execprefix}/$(get_libdir)/python${python_version}/site-packages" \
		install || die
	make DESTDIR=${D} includedir_server=/usr/include/postgresql/server includedir_internal=/usr/include/postgresql/internal install-all-headers || die
	cd ${S}/contrib
	make DESTDIR=${D} LIBDIR=${D}/usr/$(get_libdir) install || die
	cd ${S}
	dodoc COPYRIGHT HISTORY INSTALL README register.txt
	dodoc contrib/adddepend/*

	if use java; then
		# we need to remove jar file after dojar; otherwise two same jar
		# file are installed.
		java-pkg_dojar ${D}/usr/share/postgresql/java/postgresql.jar
		rm ${D}/usr/share/postgresql/java/postgresql.jar
	fi

	# backward compatibility
	for i in ${D}/usr/include/postgresql/pgsql/*
	do
		ln -s ${i} ${D}/usr/include/
	done

	cd ${S}/doc
	dodoc FAQ* README.* TODO bug.template
	if use doc; then
		cd ${S}/doc
		docinto FAQ_html
		dodoc src/FAQ/*
		docinto sgml
		dodoc src/sgml/*.{sgml,dsl}
		docinto sgml/ref
		dodoc src/sgml/ref/*.sgml
		docinto TODO.detail
		dodoc TODO.detail/*
	fi

	cd ${S}
	exeinto /etc/init.d/
	newexe "${FILESDIR}/postgresql.init-${PV%.*}" postgresql || die

	insinto /etc/conf.d/
	newins "${FILESDIR}/postgresql.conf-${PV%.*}" postgresql || die

	keepdir /var/lib/postgresql
}

pkg_postinst() {
	einfo "Execute the following command"
	einfo "emerge --config =${PF}"
	einfo "to setup the initial database environment."
	einfo ""
	einfo "Make sure the postgres user in /etc/passwd has an account setup with /bin/bash as the shell"
}

pkg_config() {
	einfo "Creating the data directory ..."
	mkdir -p ${PG_DIR}/data
	chown -Rf postgres:postgres ${PG_DIR}
	chmod 700 ${PG_DIR}/data

	einfo "Initializing the database ..."
	if [ -f ${PG_DIR}/data/PG_VERSION ] ; then
		PG_MAJOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f1 -d.`
		PG_MINOR=`cat ${PG_DIR}/data/PG_VERSION | cut -f2 -d.`
		if [ ${PG_MAJOR} -lt 7 ] || [ ${PG_MAJOR} -eq 7 -a ${PG_MINOR} -lt 3 ] ; then
			eerror "Postgres ${PV} cannot upgrade your existing databases."
			eerror "You must remove your entire database directory to continue."
			eerror "(database directory = ${PG_DIR})."
			exit 1
		else
			einfon "A postgres data directory already exists from version "; cat ${PG_DIR}/data/PG_VERSION
			einfo "Read the documentation to check how to upgrade to version ${PV}."
		fi
	else
		# On hppa, postgresql need way more than the default sem index and shmmax
		if [ "${ARCH}" = "hppa" ]; then
			SEM_IDX_MIN=1024
			SHMMAX_MIN=100000000
			SEM_IDX=`sysctl kernel.sem | awk '{ print $6 }'`
			if [ $SEM_IDX -lt ${SEM_IDX_MIN} ]; then
				eerror "The last value of /proc/sys/kernel/sem is too low for postgresql to run"
				eerror "Temporary setting this value to ${SEM_IDX_MIN} while creating the initial database."
				cat /proc/sys/kernel/sem | sed -e "s/\t${SEM_IDX}/\t${SEM_IDX_MIN}/" > /proc/sys/kernel/sem
			fi
		fi
		su postgres -c "/usr/bin/initdb --pgdata ${PG_DIR}/data"

		if [ "${ARCH}" = "hppa" ]; then
			if [ ! `sysctl kernel.sem | awk '{ print $6 }'` -eq ${SEM_IDX} ] ; then
				cat /proc/sys/kernel/sem | sed -e "s/\t${SEM_IDX_MIN}/\t${SEM_IDX}/" > /proc/sys/kernel/sem
				ewarn "Restoring the sem idx value to the previous value"
				ewarn "Please edit the last value of kernel.sem in /etc/sysctl.conf"
				ewarn "and set it to at least ${SEM_IDX_MIN}"
			fi

			if [ `sysctl kernel.shmmax | awk '{ print $3 }'` -lt ${SHMMAX_MIN} ]; then
				eerror "The current value of /proc/sys/kernel/shmmax is too low"
				eerror "for postgresql to run. Please edit /etc/sysctl.conf and set"
				eerror "this value to at least ${SHMMAX_MIN}."

			fi
		fi

		einfo "If you are upgrading from a pre-7.3 version of PostgreSQL, please read"
		einfo "the README.adddepend file for information on how to properly migrate"
		einfo "all serial columns, unique keys and foreign keys to this version."

		einfo ""
		einfo "You can use /etc/init.d/postgresql script to run PostgreSQL instead of pg_ctl."
		einfo ""
	fi
}
