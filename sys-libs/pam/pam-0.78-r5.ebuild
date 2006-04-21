# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.78-r5.ebuild,v 1.2 2006/04/21 12:01:54 flameeyes Exp $

FORCE_SYSTEMAUTH_UPDATE="no"

# BDB is internalized to get a non-threaded lib for pam_userdb.so to
# be built with.  The runtime-only dependency on BDB suggests the user
# will use the system-installed db_load to create pam_userdb databases.
# PWDB is internalized because it is specifically designed to work
# with Linux-PAM.  I'm not really certain how pervasive the Radius
# and NIS services of PWDB are at this point.

PATCH_LEVEL="1.4"
BDB_VER="4.3.27"
BDB_VER2="4.1.25"
GLIB_VER="2.6.5"
PAM_REDHAT_VER="0.78-3"

HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"

S="${WORKDIR}/Linux-PAM-${PV}"
S2="${WORKDIR}/pam-${PV}-patches"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/Linux-PAM-${PV}.tar.gz
	mirror://gentoo/pam-${PV}-patches-${PATCH_LEVEL}.tar.bz2
	berkdb? ( http://downloads.sleepycat.com/db-${BDB_VER}.tar.gz )
	pam_console? ( ftp://ftp.gtk.org/pub/gtk/v2.6/glib-${GLIB_VER}.tar.bz2 )"

LICENSE="PAM"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="berkdb pwdb selinux pam_chroot pam_console pam_timestamp nis"

RDEPEND=">=sys-libs/cracklib-2.8.3
	selinux? ( >=sys-libs/libselinux-1.28 )
	berkdb? ( >=sys-libs/db-${BDB_VER2} )
	pwdb? ( >=sys-libs/pwdb-0.62 )"

# Note that we link to static versions of glib (pam_console.so)
# and pwdb (pam_pwdb.so), so we need glib-2.6.2-r1 or later ...
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig
	>=sys-devel/autoconf-2.59
	>=sys-devel/automake-1.6
	>=sys-devel/flex-2.5.4a-r5
	pwdb? ( >=sys-libs/pwdb-0.62 )"

# Have python sandbox issues currently ...
#	doc? ( app-text/sgmltools-lite )

PROVIDE="virtual/pam"

#inherit needs to be after DEPEND definition to protect RDEPEND
inherit toolchain-funcs eutils flag-o-matic gnuconfig pam

DESCRIPTION="Pluggable Authentication Modules"

apply_pam_patches() {
	local x=
	local y=
	local patches="${T}/patches.$$"

	for x in redhat gentoo; do
		rm -f "${patches}"

		# Need to be a '| while read x', as some lines may have spaces ...
		grep -v '^#' "${S2}/list.${x}-patches" | grep -v '^$' | while read y; do
			# Remove the 'Patch[0-9]*: ' from the redhat list
			echo "${y}" | sed -e 's|^Patch.*: \(.*\)|\1|' >> "${patches}"
		done
		for y in $(cat "${patches}"); do
			epatch "${S2}/${x}-patches/${y}"
		done
	done
}

pkg_setup() {
	local x=

	#if use pwdb; then
	#	for x in libpwdb.a libcrack.a; do
	#		if [ ! -f "${ROOT}/usr/$(get_libdir)/${x}" ]; then
	#			eerror "Could not find /usr/$(get_libdir)/${x} needed to build Linux-PAM!"
	#			die "Could not find /usr/$(get_libdir)/${x} needed to build Linux-PAM!"
	#		fi
	#	done
	#fi
	#if use pam_console; then
	#	x="libglib-2.0.a"
	#	if [ ! -f "${ROOT}/usr/$(get_libdir)/${x}" ]; then
	#		eerror "Could not find /usr/$(get_libdir)/${x} needed to build Linux-PAM!"
	#		eerror "Please remerge glib-2.6.* to make sure you have static changes."
	#		die "Could not find /usr/$(get_libdir)/${x} needed to build Linux-PAM!"
	#	fi
	#fi

	return 0
}

src_unpack() {
	local x=

	unpack ${A} || die "Couldn't unpack ${A}"

	cd ${S} || die
	tar --no-same-owner -zxf ${S2}/pam-redhat-${PAM_REDHAT_VER}.tar.gz \
		|| die "Couldn't unpack pam-redhat-${PAM_REDHAT_VER}.tar.gz"
	# These ones we do not want, or do not work with non RH
	rm -rf ${S}/modules/{pam_rps,pam_postgresok}

	apply_pam_patches

	if use selinux; then
		epatch ${S2}/gentoo-patches/pam-0.78-selinux.patch
		epatch ${S2}/gentoo-patches/pam-0.77-selinux-CAN-2005-2977.patch
		epatch ${S2}/gentoo-patches/pam-0.78-selinux-getseuserbyname.patch
	fi

	# Check which extra modules should be built
	# (Do this after apply_pam_patches(), else some may fail)
	for x in pam_chroot pam_console pam_timestamp; do
		use "${x}" || rm -rf "${S}/modules/${x}"
	done
	use berkdb || rm -rf "${S}/modules/pam_userdb"
	use pwdb || rm -rf "${S}/modules/pam_pwdb"
	use pwdb || rm -rf "${S}/modules/pam_radius"

	for x in $(find ${S} -type f -name 'Makefile*'); do
		use nis || sed -i -e 's: -DNIS::g' "${x}"
	done
	# NIS patch is broken for now
	use nis && echo 'NIS=yes' >> "${S}/Make.Rules.in"

	# Fixup libdir for 64bit arches
	sed -ie "s:@get_libdir:$(get_libdir):" ${S}/configure.in

	for readme in modules/pam_*/README; do
		cp -f "${readme}" doc/txts/README.$(dirname "${readme}" | \
			sed -e 's|^modules/||')
	done

	# Bug #80604 (If install-sh do not exist, touch it)
	cp /usr/share/automake/install-sh ${S}/ 2>/dev/null || touch install-sh
	export WANT_AUTOCONF=2.5
	autoconf || die

	epatch "${FILESDIR}/${P}-inttypes.patch"
	epatch "${FILESDIR}/${P}-xauth-path.patch"
}

src_compile() {
	local BDB_DIR="${WORKDIR}/db-${BDB_VER}"
	local GLIB_DIR="${WORKDIR}/glib-${GLIB_VER}"

	# Bug #70471 (Compile issues with other locales)
	export LANG=C LC_ALL=C

	if use berkdb ; then
		einfo "Building Berkley DB ${BDB_VER}..."
		cd "${BDB_DIR}/build_unix" || die

		# Pam uses berkdb, which db-4.1.x series can't detect mips64, so we fix it
		if use mips ; then
			einfo "Updating BDB config.{guess,sub} for mips"
			S="${BDB_DIR}/dist" \
			gnuconfig_update
		fi

		#echo db_cv_mutex=UNIX/fcntl > config.cache
		#./s_config
		CFLAGS="${CFLAGS} -fPIC" \
		../dist/configure \
			--host=${CHOST} \
			--cache-file=config.cache \
			--disable-compat185 \
			--disable-cxx \
			--disable-diagnostic \
			--disable-dump185 \
			--disable-java \
			--disable-rpc \
			--disable-tcl \
			--disable-shared \
			--disable-o_direct \
			--with-pic \
			--with-uniquename=_pam \
			--with-mutex="UNIX/fcntl" \
			--prefix="${S}" \
			--includedir="${S}/include" \
			--libdir="${S}/lib" || die "Bad BDB ./configure"

		# XXX: hack out O_DIRECT support in db4 for now.
		#      (Done above now with --disable-o_direct now)

		make CC="$(tc-getCC)" || die "BDB build failed"
		make install || die
	fi

	if use pam_console ; then
		einfo "Building GLIB ${GLIB_VER}..."
		cd "${GLIB_DIR}" || die

		# The __attribute__((visibility("hidden"))) causes TEXTREL issues
		sed -i -s 's:G_GNUC_INTERNAL::g' "${GLIB_DIR}/glib"/*.c

		CFLAGS="${CFLAGS} -fPIC" \
		./configure \
			--host=${CHOST} \
			--enable-static \
			--disable-shared \
			--with-pic \
			--disable-threads \
			--with-threads=none \
			--prefix="${S}" \
			--includedir="${S}/include" \
			--libdir="${S}/lib" || die "Bad GLIB ./configure"

		# Do not need to build the whole shebang
		cd "${GLIB_DIR}/glib" || die
		make CC="$(tc-getCC)" || die "GLIB build failed"
		make install || die
		# Install pkg-config stuff and needed headers
		cd "${GLIB_DIR}" || die
		make install-pkgconfigDATA install-exec-local || die
	fi

	if use berkdb || use pam_console ; then
		# Make sure out static libs are used
		export CFLAGS="-I${S}/include -Wl,-L${S}/lib ${CFLAGS}"
		export LDFLAGS="-L${S}/lib ${LDFLAGS}"
		export LIBNAME="lib"
		# Make sure pkg-config can find glib even if not installed in system
		export PKG_CONFIG_PATH="${S}/lib/pkgconfig:${PKG_CONFIG_PATH}"
	fi

	einfo "Building Linux-PAM ${PV}..."
	cd ${S}
	econf --enable-static-libpam \
		--enable-fakeroot="${D}" \
		--libdir="/$(get_libdir)" \
		--enable-isadir="../../$(get_libdir)/security" \
		|| die

	# Python stuff in docs gives sandbox problems
	sed -i -e 's|modules doc examples|modules|' Makefile

	# Fix warnings for gcc-2.95.3
	if [[ $(gcc-version) = "2.95" ]] ; then
		sed -i -e "s:-Wpointer-arith::" Make.Rules
	fi

	if ! use berkdb ; then
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
		sed -i -e "s:^#define HAVE_NDBM_H.*$:/* #undef HAVE_NDBM_H */:" \
			_pam_aconf.h
	fi

	make CC="$(tc-getCC)" || die "PAM build failed"
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
	for x in ${S}/modules/pam_*; do
		if [[ -d ${x} ]] ; then
			local mod_name=$(basename "${x}")
			local sec_dir="${D}/$(get_libdir)/security"

			if ! ls -1 "${sec_dir}/${mod_name}"*.so &> /dev/null ; then
				echo
				eerror "ERROR: ${mod_name} module did not build."
				echo
				die "${mod_name} module did not build."
			fi
			if [[ -n $(ldd "${sec_dir}/${mod_name}"*.so 2>&1 | \
			           grep "/usr/lib/" | \
			           grep "/usr/$(get_libdir)/" | \
			           grep -v "/usr/lib/gcc" | \
			           grep -v "/usr/$(get_libdir)/gcc" | \
			           grep -v "libsandbox") ]] ; then
				echo
				eerror "ERROR: ${mod_name} have dependencies in /usr."
				echo
				die "${mod_name} have dependencies in /usr."
			fi
		fi
	done

	dodir /usr/$(get_libdir)
	cd ${D}/$(get_libdir)
	for x in pam pamc pam_misc; do
		rm lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so
		ln -s lib${x}.so.${PV} lib${x}.so.0
		mv lib${x}.a ${D}/usr/$(get_libdir)
		# See bug #4411
		gen_usr_ldscript lib${x}.so
	done

	cd ${S}

	# need this for pam_console
	keepdir /var/run/console

	for x in ${FILESDIR}/pam.d/*; do
		[[ -f ${x} ]] && dopamd ${x}
	done

	# Only add this one if needed.
	if [[ ${FORCE_SYSTEMAUTH_UPDATE} = "yes" ]] ; then
		newpamd ${FILESDIR}/pam.d/system-auth system-auth.new || \
			die "Failed to install system-auth.new!"
	fi

	insinto /etc/security
	doins ${FILESDIR}/pam_env.conf
	doman doc/man/*.[0-9]

	dodoc CHANGELOG Copyright README
	docinto modules ; dodoc modules/README ; dodoc doc/txts/README.*
	# Install our own README.pam_console
	docinto ; dodoc ${FILESDIR}/README.pam_console
	docinto txt ; dodoc doc/specs/*.txt #doc/txts/*.txt
#	docinto print ; dodoc doc/ps/*.ps

#	docinto html
#	dohtml -r doc/html/
}

pkg_postinst() {
	echo
	einfo "If you have sshd running, please restart it to avoid possible login issues."
	echo
	ebeep
	sleep 3

	if [[ ${FORCE_SYSTEMAUTH_UPDATE} = "yes" ]] ; then
		local CHECK1=$(md5sum ${ROOT}/etc/pam.d/system-auth | cut -d ' ' -f 1)
		local CHECK2=$(md5sum ${ROOT}/etc/pam.d/system-auth.new | cut -d ' ' -f 1)

		if [[ ${CHECK1} != "${CHECK2}" ]] ; then
			ewarn "Due to a security issue, ${ROOT}etc/pam.d/system-auth "
			ewarn "is being updated automatically. Your old "
			ewarn "system-auth will be backed up as:"
			ewarn
			ewarn "  ${ROOT}etc/pam.d/system-auth.bak"
			echo

			cp -pPR ${ROOT}/etc/pam.d/system-auth \
				${ROOT}/etc/pam.d/system-auth.bak;
			mv -f ${ROOT}/etc/pam.d/system-auth.new \
				${ROOT}/etc/pam.d/system-auth
			rm -f ${ROOT}/etc/pam.d/._cfg????_system-auth
		else
			rm -f ${ROOT}/etc/pam.d/system-auth.new
		fi
	fi

	if use pam_console; then
		echo
		einfo "If you want to enable the pam_console module, please follow"
		einfo "the instructions in /usr/share/doc/${PF}/README.pam_console."
		echo
	fi
}
