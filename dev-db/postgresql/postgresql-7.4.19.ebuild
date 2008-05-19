# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.4.19.ebuild,v 1.9 2008/05/19 19:22:40 dev-zero Exp $

inherit eutils gnuconfig flag-o-matic multilib toolchain-funcs versionator

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"

DESCRIPTION="Sophisticated and powerful Object-Relational DBMS."
HOMEPAGE="http://www.postgresql.org/"
SRC_URI="mirror://postgresql/source/v${PV}/${PN}-${PV}.tar.bz2"
LICENSE="POSTGRESQL"
SLOT="0"
IUSE="doc kerberos nls pam perl pg-intdatetime python readline selinux ssl tcl test xml zlib"

RDEPEND="~dev-db/libpq-${PV}
		>=sys-libs/ncurses-5.2
		kerberos? ( virtual/krb5 )
		pam? ( virtual/pam )
		perl? ( >=dev-lang/perl-5.6.1-r2 )
		python? ( >=dev-lang/python-2.2 dev-python/egenix-mx-base )
		readline? ( >=sys-libs/readline-4.1 )
		selinux? ( sec-policy/selinux-postgresql )
		ssl? ( >=dev-libs/openssl-0.9.6-r1 )
		tcl? ( >=dev-lang/tcl-8 )
		xml? ( dev-libs/libxml2 dev-libs/libxslt )
		zlib? ( >=sys-libs/zlib-1.1.3 )
		virtual/logger
		!dev-db/postgresql-server"
DEPEND="${RDEPEND}
		sys-devel/autoconf
		>=sys-devel/bison-1.875
		nls? ( sys-devel/gettext )
		xml? ( dev-util/pkgconfig )"

PG_DIR="/var/lib/postgresql"
[[ -z "${PG_MAX_CONNECTIONS}" ]] && PG_MAX_CONNECTIONS="512"

cluster_exists() {
	[[ -f "${PG_DIR}/data/PG_VERSION" ]] && return 0
	return 1
}

pkg_setup() {
	if hasq pg-hier ${USE} ; then
		ewarn "Warning: pg-hier USE-flag detected:"
		ewarn "The hier-patch has been dropped for this version and the pg-hier USE-flag is therefore deprecated."
		ewarn "If you really used the 'hier' patch in your database with the 'CONNECT BY' statement,"
		ewarn "you should stop now and reconsider. You will be able to reuse your data, but not"
		ewarn "any VIEWS or QUERIES based on that statement."
		ewarn "Please disable the pg-hier USE-flag!"
		ebeep 3
		if cluster_exists ; then
			eerror "There is already a database in '${PG_DIR}/data' and you have the pg-hier USE-flag set."
			eerror "Please read the message above first. If you decide that the warnings there don't"
			eerror "apply to your situation, dump the database using pg_dump and move the '${PG_DIR}/data'"
			eerror "away. Then restart the merge. After that create a new database cluster and use pg_restore to"
			eerror "re-import the previously dumped data."
			eerror "Moving '${PG_DIR}/data' temporarely away or just disable the 'pg-hier' USE-flag won't work."
			die "Can't update this database."
		fi
	fi
	if cluster_exists ; then
		local cluster_version=$(cat "${PG_DIR}/data/PG_VERSION")
		if [[ ${cluster_version} != $(get_version_component_range 1-2) ]] ; then
			eerror "There is a database in '${PG_DIR}/data' from PostgreSQL version ${cluster_version}."
			eerror "PostgreSQL doesn't support upgrades between major versions, you have to use pg_dump"
			eerror "to dump your existing database. Then move your '${PG_DIR}/data' directory away and"
			eerror "restart the merge. After that create a new database cluster and use pg_restore to"
			eerror "re-import the previously dumped data."
			die "Can't update this database."
		fi
	fi

	enewgroup postgres 70
	enewuser postgres 70 /bin/bash /var/lib postgres
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# libpq is provided separately as dev-db/libpq
	sed -i -e 's/^DIRS := libpq ecpg/DIRS := ecpg/' src/interfaces/Makefile
	sed -i -e '/\W\+\$.MAKE. -C include \$/d' src/Makefile
	sed -i -e '/^\W\+psql scripts pg_config pg_controldata/ s/pg_config //' src/bin/Makefile

	epatch "${FILESDIR}/${P}-hppa-testandset.patch"

	# Prepare package for future tests
	if use test ; then
		# We need to run the tests as a non-root user, portage seems the most fitting here,
		# so if userpriv is enabled, we use it directly. If userpriv is disabled, well, we
		# don't support that in this version of PostgreSQL ... :)
		mkdir -p "${S}/src/test/regress/tmp_check"
		chown portage "${S}/src/test/regress/tmp_check"
		einfo "Tests will be run as user portage."
	fi
}

src_compile() {
	filter-flags -ffast-math -feliminate-dwarf2-dups

	# Correctly support the XML stuff
	if use xml ; then
		CFLAGS="${CFLAGS} $(pkg-config --cflags libxml-2.0)"
		LIBS="${LIBS} $(pkg-config --libs libxml-2.0)"
	fi

	# Detect mips systems properly
	gnuconfig_update

	cd "${S}"

	./configure --prefix=/usr \
		--includedir=/usr/include/postgresql/pgsql \
		--sysconfdir=/etc/postgresql \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--docdir=/usr/share/doc/${PF} \
		--libdir=/usr/$(get_libdir) \
		--enable-depend \
		$(use_with kerberos krb5) \
		$(use_enable nls ) \
		$(use_with pam) \
		$(use_with perl) \
		$(use_enable pg-intdatetime integer-datetimes ) \
		$(use_with python) \
		$(use_with readline) \
		$(use_with ssl openssl) \
		$(use_with tcl) \
		--without-tk \
		$(use_with zlib) \
		|| die "configure failed"

	emake -j1 LD="$(tc-getLD) $(get_abi_LDFLAGS)" || die "main emake failed"

	cd "${S}/contrib"
	emake -j1 LD="$(tc-getLD) $(get_abi_LDFLAGS)" || die "contrib emake failed"

	if use xml ; then
		cd "${S}/contrib/xml"
		emake -j1 LD="$(tc-getLD) $(get_abi_LDFLAGS)" || die "contrib/xml emake failed"
	fi
}

src_install() {
	if use perl ; then
		mv -f "${S}/src/pl/plperl/GNUmakefile" "${S}/src/pl/plperl/GNUmakefile_orig"
		sed -e "s:\$(DESTDIR)\$(plperl_installdir):\$(plperl_installdir):" \
			"${S}/src/pl/plperl/GNUmakefile_orig" > "${S}/src/pl/plperl/GNUmakefile"
	fi

	cd "${S}"
	emake -j1 DESTDIR="${D}" LIBDIR="${D}/usr/$(get_libdir)" install || die "main emake install failed"

	cd "${S}/contrib"
	emake -j1 DESTDIR="${D}" LIBDIR="${D}/usr/$(get_libdir)" install || die "contrib emake install failed"

	if use xml ; then
		cd "${S}/contrib/xml"
		emake -j1 DESTDIR="${D}" LIBDIR="${D}/usr/$(get_libdir)" install || die "contrib/xml emake install failed"
	fi

	cd "${S}"
	dodoc README HISTORY
	dodoc contrib/adddepend/*

	cd "${S}/doc"
	dodoc FAQ* README.* TODO bug.template

	if use doc ; then
		cd "${S}/doc"
		docinto FAQ_html
		dodoc src/FAQ/*
		docinto sgml
		dodoc src/sgml/*.{sgml,dsl}
		docinto sgml/ref
		dodoc src/sgml/ref/*.sgml
		docinto TODO.detail
		dodoc TODO.detail/*
	fi

	newinitd "${FILESDIR}/postgresql.init-${PV%.*}" postgresql || die "Inserting init.d-file failed"
	newconfd "${FILESDIR}/postgresql.conf-${PV%.*}" postgresql || die "Inserting conf.d-file failed"

	newinitd "${FILESDIR}/pg_autovacuum.init-${PV%.*}" pg_autovacuum || die "Inserting pg_autovacuum init.d-file failed"
	newconfd "${FILESDIR}/pg_autovacuum.conf-${PV%.*}" pg_autovacuum || die "Inserting pg_autovacuum conf.d-file failed"
	dosed "s:___DOCDIR___:/usr/share/doc/${PF}:" /etc/init.d/pg_autovacuum
}

pkg_postinst() {
	elog "Execute the following command to setup the initial database environment:"
	elog
	elog "emerge --config =${PF}"
	elog
	elog "If you need a global psqlrc-file, you can place it in '${ROOT%/}/etc/postgresql/'."
}

pkg_config() {
	einfo "Creating the data directory ..."
	mkdir -p "${PG_DIR}/data"
	chown -Rf postgres:postgres "${PG_DIR}"
	chmod 0700 "${PG_DIR}/data"

	einfo "Initializing the database ..."
	if [[ -f "${PG_DIR}/data/PG_VERSION" ]] ; then
		eerror "PostgreSQL ${PV} cannot upgrade your existing databases."
		eerror "You must remove your entire database directory to continue."
		eerror "(database directory = ${PG_DIR})."
		die "Remove your database directory to continue"
	else
		if use kernel_linux ; then
			local SEM=`sysctl -n kernel.sem | cut -f-3`
			local SEMMNI=`sysctl -n kernel.sem | cut -f4`
			local SEMMNI_MIN=`expr \( ${PG_MAX_CONNECTIONS} + 15 \) / 16`
			local SHMMAX=`sysctl -n kernel.shmmax`
			local SHMMAX_MIN=`expr 500000 + 30600 \* ${PG_MAX_CONNECTIONS}`

			if [ ${SEMMNI} -lt ${SEMMNI_MIN} ] ; then
				eerror "The current value of SEMMNI is too low"
				eerror "for PostgreSQL to run ${PG_MAX_CONNECTIONS} connections!"
				eerror "Temporary setting this value to ${SEMMNI_MIN} while creating the initial database."
				echo ${SEM} ${SEMMNI_MIN} > /proc/sys/kernel/sem
			fi

			su postgres -c "/usr/bin/initdb --pgdata ${PG_DIR}/data"

			if [ ! `sysctl -n kernel.sem | cut -f4` -eq ${SEMMNI} ] ; then
				echo ${SEM} ${SEMMNI} > /proc/sys/kernel/sem
				ewarn "Restoring the SEMMNI value to the previous value."
				ewarn "Please edit the last value of kernel.sem in /etc/sysctl.conf"
				ewarn "and set it to at least ${SEMMNI_MIN}:"
				ewarn
				ewarn "  kernel.sem = ${SEM} ${SEMMNI_MIN}"
				ewarn
			fi

			if [ ${SHMMAX} -lt ${SHMMAX_MIN} ] ; then
				eerror "The current value of SHMMAX is too low for postgresql to run."
				eerror "Please edit /etc/sysctl.conf and set this value to at least ${SHMMAX_MIN}:"
				eerror
				eerror "  kernel.shmmax = ${SHMMAX_MIN}"
				eerror
			fi
		else
			su postgres -c "/usr/bin/initdb --pgdata ${PG_DIR}/data"
		fi

		einfo
		einfo "You can use the '${ROOT%/}/etc/init.d/postgresql' script to run PostgreSQL instead of 'pg_ctl'."
		einfo
	fi
}

src_test() {
	cd "${S}"

	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	if hasq userpriv ${FEATURES} ; then
		if ! emake -j1 check ; then
			hasq test ${FEATURES} && die "Make check failed. See above for details."
			hasq test ${FEATURES} || eerror "Make check failed. See above for details."
		fi
	else
		eerror "Tests won't be run if FEATURES=userpriv is disabled!"
	fi

	einfo "Yes, there are other tests which could be run."
	einfo "... and no, we don't plan to add/support them."
	einfo "For now, the main regressions tests will suffice."
	einfo "If you think other tests are necessary, please submit a"
	einfo "bug including a patch for this ebuild to enable them."
}
