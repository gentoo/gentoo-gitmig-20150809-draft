# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.99.5.0-r1.ebuild,v 1.1 2006/07/01 19:27:06 azarah Exp $

inherit libtool multilib eutils autotools pam toolchain-funcs gnuconfig

P_VER="1.0"
# BDB is internalized to get a non-threaded lib for pam_userdb.so to
# be built with.  The runtime-only dependency on BDB suggests the user
# will use the system-installed db_load to create pam_userdb databases.
BDB_VER="4.3.29"

MY_P="Linux-PAM-${PV}"

HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"
DESCRIPTION="Linux-PAM (Pluggable Authentication Modules)"

SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/${MY_P}.tar.bz2
	berkdb? ( http://downloads.sleepycat.com/db-${BDB_VER}.tar.gz )
	mirror://gentoo/${P}-patches-${P_VER}.tar.bz2
	http://dev.gentoo.org/~azarah/pam/${P}-patches-${P_VER}.tar.bz2"

LICENSE="PAM"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="berkdb doc nls selinux"

DEPEND="nls? ( sys-devel/gettext )
	doc? ( app-text/ghostscript
	       app-text/tetex
	       >=app-text/linuxdoc-tools-0.9.21_p4
	       www-client/w3m
	       dev-libs/libxslt
	       app-text/docbook-xsl-stylesheets
	       app-text/docbook-xml-dtd )"
RDEPEND="nls? ( virtual/libintl )
	>=sys-libs/cracklib-2.8.3
	selinux? ( >=sys-libs/libselinux-1.28 )
	berkdb? ( >=sys-libs/db-${BDB_VER} )"
DEPEND="${DEPEND} ${RDEPEND}"

S="${WORKDIR}/${MY_P}"

RESTRICT="confcache"

PROVIDE="virtual/pam"

src_unpack() {
	unpack ${A}

	cd "${S}"

	for readme in modules/pam_*/README; do
		cp -f "${readme}" doc/txts/README.$(dirname "${readme}" | \
			sed -e 's|^modules/||')
	done

	# Not sure if this should be applied
	rm -f "${WORKDIR}/patch/*_all_0.99.5.0-selinux-drop-multiple.patch.bz2"
	epatch "${WORKDIR}/patch"
	AT_M4DIR="m4" eautoreconf

	#elibtoolize
}

src_compile() {
	local myconf
	local BDB_DIR="${WORKDIR}/db-${BDB_VER}"

	# If docs fails to generate with the following type of errors:
	#
	#   /usr/bin/nsgmls:.*:E: "X0393" is not a function name
	#
	# then its is probably sgml-common that did not add all its on catalogs
	# properly, namely:
	#
	#   /usr/share/sgml/sgml-iso-entities-8879.1986/catalog
	#
	if ! use doc ; then
		export SGML2PS=no
		export SGML2TXT=no
		export SGML2HTML=no
		export SGML2LATEX=no
		export PS2PDF=no
	fi

	if use hppa || use elibc_FreeBSD; then
		myconf="${myconf} --disable-pie"
	fi

	# BDB is internalized to get a non-threaded lib for pam_userdb.so to
	# be built with.  To demand-load a shared library which uses threads
	# into an application which doesn't is a Very Bad Idea!
	if use berkdb ; then
		einfo "Building Berkley DB ${BDB_VER}..."
		cd "${BDB_DIR}/build_unix" || die

		# Pam uses berkdb, which db-4.1.x series can't detect mips64, so we fix it
		if use mips ; then
			einfo "Updating BDB config.{guess,sub} for mips"
			S="${BDB_DIR}/dist" \
			gnuconfig_update
		fi

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
			--with-uniquename="_pam" \
			--with-mutex="UNIX/fcntl" \
			--prefix="${S}" \
			--includedir="${S}/include" \
			--libdir="${S}/lib" || die "Bad BDB ./configure"

		# XXX: hack out O_DIRECT support in db4 for now.
		#      (Done above now with --disable-o_direct now)

		make CC="$(tc-getCC)" || die "BDB build failed"
		make install || die

		# We link against libdb_pam (*-dbpam.patch), else stupid libtool goes
		# and relinks it during install to libdb in /usr/lib
		cp -f "${S}/lib/libdb.a" "${S}/lib/libdb_pam.a"

		# Make sure out static libs are used
		export CFLAGS="-I${S}/include ${CFLAGS}"
		export LDFLAGS="-L${S}/lib ${LDFLAGS}"
		cd ${S}
	fi

	econf \
		$(use_enable nls) \
		--enable-securedir=/$(get_libdir)/security \
		--enable-isadir=/$(get_libdir)/security \
		--disable-dependency-tracking \
		--disable-prelude \
		--enable-docdir=/usr/share/doc/${PF} \
		$(use_enable selinux selinux) \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	# Make sure every module built.
	# Do not remove this, as some module can fail to build
	# and effectively lock the user out of his system.
	einfo "Checking module dependencies..."
	for x in "${D}/$(get_libdir)/security/"pam_*.so; do
		if [[ -n $(ldd "${x}" 2>&1 | \
		               grep "\/usr\/\(lib\|$(get_libdir)\)\/" | \
		               grep -v "\/usr\/\(lib\|$(get_libdir)\)\/gcc" | \
		               grep -v "libsandbox") ]] ; then
			local mod_name=$(basename "${x}")

			echo
			eerror "ERROR: ${mod_name} have dependencies in /usr."
			echo
			die "${mod_name} have dependencies in /usr."
		fi
	done

	dodir /$(get_libdir)
	mv "${D}/usr/$(get_libdir)/libpam.so"* "${D}/$(get_libdir)/"
	mv "${D}/usr/$(get_libdir)/libpamc.so"* "${D}/$(get_libdir)/"
	mv "${D}/usr/$(get_libdir)/libpam_misc.so"* "${D}/$(get_libdir)/"
	gen_usr_ldscript libpam.so libpamc.so libpam_misc.so

	# No, we don't really need .la files for PAM modules.
	rm -f "${D}/$(get_libdir)/security/"*.la

	use berkdb || rm -f "${D}/$(get_libdir)/security/pam_userdb*"
	use selinux || rm -f "${D}/$(get_libdir)/security/pam_selinux*"

	dodoc CHANGELOG ChangeLog README AUTHORS Copyright
	docinto modules ; dodoc doc/txts/README.*

	for x in "${FILESDIR}/pam.d/"*; do
		[[ -f "${x}" ]] && dopamd "${x}"
	done
}

pkg_postinst() {
	ewarn " "
	ewarn "Pay attention! This ebuild is still highly experimental. Don't use"
	ewarn "in production environments. We don't guarrantee it's working at all."
	ewarn "Please also note that RedHat patches are not applied, thus stuff"
	ewarn "like pam_stack is not present at this time."
	ewarn " "
}
