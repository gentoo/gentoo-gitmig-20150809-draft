# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.77-r2.ebuild,v 1.2 2004/11/12 21:06:17 vapier Exp $

PATCH_LEVEL="1.3"
BDB_VER="4.1.25"
PAM_REDHAT_VER="0.77-4"

RDEPEND=">=sys-libs/cracklib-2.7-r8
	selinux? ( sys-libs/libselinux )
	berkdb? ( >=sys-libs/db-${BDB_VER} )"

DEPEND="$RDEPEND
	dev-lang/perl
	=dev-libs/glib-1.2*
	>=sys-devel/autoconf-2.59
	>=sys-devel/automake-1.6
	>=sys-devel/flex-2.5.4a-r5
	pwdb? ( >=sys-libs/pwdb-0.62 )"

# Have python sandbox issues currently ...
#	doc? ( app-text/sgmltools-lite )

# BDB is internalized to get a non-threaded lib for pam_userdb.so to
# be built with.  The runtime-only dependency on BDB suggests the user
# will use the system-installed db_load to create pam_userdb databases.
# PWDB is internalized because it is specifically designed to work
# with Linux-PAM.  I'm not really certain how pervasive the Radius
# and NIS services of PWDB are at this point.
#
# With all the arch's we support, I rather use external pwdb, and then
# link statically to it - <azarah@gentoo.org> (09 Nov 2003).

#inherit needs to be after DEPEND definition to protect RDEPEND
inherit gcc eutils flag-o-matic gnuconfig

# Note that we link to static versions of glib (pam_console.so)
# and pwdb (pam_pwdb.so) ...

HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"
DESCRIPTION="Pluggable Authentication Modules"

S="${WORKDIR}/Linux-PAM-${PV}"
S2="${WORKDIR}/pam-${PV}-patches"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/Linux-PAM-${PV}.tar.gz
	mirror://gentoo/${P}-patches-${PATCH_LEVEL}.tar.bz2
	berkdb? ( http://www.sleepycat.com/update/snapshot/db-${BDB_VER}.tar.gz )"

LICENSE="PAM"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE="berkdb pwdb selinux"

apply_pam_patches() {
	local x=
	local patch=

	for x in redhat gentoo
	do
		cat ${S2}/list.${x}-patches | grep -v '^#' | grep -v '^$' | while read X
		do
			patch="$(echo $X | sed -e 's|^Patch.*: \(.*\)|\1|')"
			epatch ${S2}/${x}-patches/${patch}
		done
	done
}

pkg_setup() {
	local x=

	if use pwdb; then
		for x in libpwdb.a libcrack.a; do
			if [ ! -f "${ROOT}/usr/$(get_libdir)/${x}" ]; then
				eerror "Could not find /usr/$(get_libdir)/${x} needed to build Linux-PAM!"
				die "Could not find /usr/$(get_libdir)/${x} needed to build Linux-PAM!"
			fi
		done
	fi

	return 0
}

src_unpack() {
	unpack ${A} || die "Couldn't unpack ${A}"

	cd ${S} || die
	tar -zxf ${S2}/pam-redhat-${PAM_REDHAT_VER}.tar.gz \
		|| die "Couldn't unpack pam-redhat-${PAM_REDHAT_VER}.tar.gz"

	apply_pam_patches

	use selinux && epatch ${S2}/gentoo-patches/pam-selinux.patch

	for readme in modules/pam_*/README ; do
		cp -f "${readme}" doc/txts/README.$(dirname "${readme}" | \
			sed -e 's|^modules/||')
	done

	cp /usr/share/automake/install-sh . || die
	export WANT_AUTOCONF=2.5
	autoconf || die
}

src_compile() {
	export CFLAGS="${CFLAGS} -fPIC"

	if use berkdb
	then
		einfo "Building Berkley DB ${BDB_VER}..."
		cd ${WORKDIR}
		cd db-${BDB_VER}/dist || die

		# Pam uses berkdb, which db-4.1.x series can't detect mips64, so we fix it
		if use mips; then
			einfo "Updating berkdb config.{guess,sub} for mips"
			local OLDS="${S}"
			S="${WORKDIR}/db-${BDB_VER}/dist"
			gnuconfig_update
			S="${OLDS}"
		fi

		echo db_cv_mutex=UNIX/fcntl > config.cache
		./s_config
		./configure \
			--cache-file=config.cache \
			--disable-compat185 \
			--disable-cxx \
			--disable-diagnostic \
			--disable-dump185 \
			--disable-java \
			--disable-rpc \
			--disable-tcl \
			--disable-shared \
			--with-pic \
			--with-uniquename=_pam \
			--prefix=${S} \
			--includedir=${S}/include \
			--libdir=${S}/lib || die "Bad BDB ./configure"

		# XXX hack out O_DIRECT support in db4 for now.
		perl -pi -e 's/#define HAVE_O_DIRECT 1/#undef HAVE_O_DIRECT/' \
			db_config.h

		make || die "BDB build failed"
		make install || die

		export CPPFLAGS="-I${S}/include"
		export LDFLAGS="-L${S}/lib"
		export LIBNAME="lib"
	fi

	if [ "${ARCH}" = "alpha" ]
	then
		if [ ! -z "$(strings -a /usr/lib/libglib.a | grep -i 'Compaq Computer Corp.')" ]
		then
			# should be LDFLAGS, but this configure is screwy.
			echo
			einfo "It looks like you compiled glib with ccc, this is okay, but"
			einfo "I'll need to force gcc to link with libots...."
			echo
			append-flags -lots
			sed -i -e 's/$(CC) -o/$(CC) -lots -o/g' ${S}/modules/pam_pwdb/Makefile
		fi
	fi

	einfo "Building Linux-PAM ${PV}..."
	cd ${S}
	./configure \
		--libdir=/$(get_libdir) \
		--enable-static-libpam \
		--enable-fakeroot=${D} \
		--enable-isadir=/$(get_libdir)/security \
		--host=${CHOST} || die

	# Python stuff in docs gives sandbox problems
	sed -i -e 's|modules doc examples|modules|' Makefile

	# Fix warnings for gcc-2.95.3
	if [ "$(gcc-version)" = "2.95" ]
	then
		sed -i -e "s:-Wpointer-arith::" Make.Rules
	fi

	if ! use berkdb
	then
		# Do not build pam_userdb.so ...
		sed -i -e "s:^HAVE_NDBM_H=yes:HAVE_NDBM_H=no:" \
			-e "s:^HAVE_LIBNDBM=yes:HAVE_LIBNDBM=no:" \
			-e "s:^HAVE_LIBDB=yes:HAVE_LIBDB=no:" \
			Make.Rules

		# Also edit the configuration file else the wrong include files
		# get used
		sed -i -e "s:^#define HAVE_NDBM_H.*$:/* #undef HAVE_NDBM_H */:" \
		       -e "s:^#define HAVE_DB_H.*$:/* #undef HAVE_DB_H */:" \
		       _pam_aconf.h

	else
		# Do not link pam_userdb.so to db-1.85 ...
		sed -i -e "s:^HAVE_NDBM_H=yes:HAVE_NDBM_H=no:" \
			-e "s:^HAVE_LIBNDBM=yes:HAVE_LIBNDBM=no:" \
			Make.Rules

		# Also edit the configuration file else the wrong include files
		# get used
		sed -i -e "s:^#define HAVE_NDBM_H.*$:/* #undef HAVE_NDBM_H */:" _pam_aconf.h
	fi

	make || die "PAM build failed"
}

src_install() {
	local x=

	einfo "Installing Linux-PAM ${PV}..."
	make FAKEROOT=${D} \
		LDCONFIG="" \
		install || die

	# Make sure every module built.
	# Do not remove this, as some module can fail to build
	# and effectively lock the user out of his system.
	einfo "Checking if all modules were built..."
	for x in ${S}/modules/pam_*
	do
		if [ -d ${x} ]
		then
			# Its OK if the module failed when we didnt ask for it anyway
			if ! ls -1 ${D}/$(get_libdir)/security/$(basename ${x})*.so &> /dev/null
			then
				if ! use berkdb && [ "$(basename ${x})" = "pam_userdb" ]
				then
					continue
				fi
				if ! use pwdb && [ "$(basename ${x})" = "pam_pwdb" ]
				then
					continue
				fi
				if ! use pwdb && [ "$(basename ${x})" = "pam_radius" ]
				then
					continue
				fi
				eerror "ERROR: $(basename ${x}) module did not build."
				exit 1
			else
			# Remove the ones we didnt want if it ended up building ok anyways
				if ! use berkdb && [ "$(basename ${x})" = "pam_userdb" ]
				then
					rm -f ${D}/$(get_libdir)/security/pam_userdb*
				fi
				if ! use pwdb && [ "$(basename ${x})" = "pam_pwdb" ]
				then
					rm -f ${D}/$(get_libdir)/security/pam_pwdb*
				fi
				if ! use pwdb && [ "$(basename ${x})" = "pam_radius" ]
				then
					rm -f ${D}/$(get_libdir)/security/pam_radius*
				fi
			fi
		fi
	done

	dodir /usr/$(get_libdir)
	cd ${D}/$(get_libdir)
	for x in pam pamc pam_misc
	do
		rm lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so.0
		mv lib${x}.a ${D}/usr/$(get_libdir)
		# See bug #4411
		gen_usr_ldscript lib${x}.so
	done

	cd ${S}
	doman doc/man/*.[58]

	dodoc CHANGELOG Copyright README
	docinto modules ; dodoc modules/README ; dodoc doc/txts/README.*
	docinto txt ; dodoc doc/specs/*.txt #doc/txts/*.txt
#	docinto print ; dodoc doc/ps/*.ps

#	docinto html
#	dohtml -r doc/html/

	# need this for pam_console
	keepdir /var/run/console

	insinto /etc/pam.d
	for x in ${FILESDIR}/${PVR}/pam.d/*
	do
		if [ -f ${x} ]
		then
			doins ${x}
		fi
	done
}
