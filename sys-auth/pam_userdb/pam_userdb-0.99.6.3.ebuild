# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_userdb/pam_userdb-0.99.6.3.ebuild,v 1.13 2007/07/02 15:28:53 peper Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit libtool multilib eutils pam autotools toolchain-funcs flag-o-matic

# BDB is internalized to get a non-threaded lib for pam_userdb.so to
# be built with.  The runtime-only dependency on BDB suggests the user
# will use the system-installed db_load to create pam_userdb databases.
BDB_VER="4.3.29"

MY_P="Linux-PAM-${PV}"

HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"
DESCRIPTION="Linux-PAM pam_userdb (Berkeley DB) module"

SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/${MY_P}.tar.bz2
	http://downloads.sleepycat.com/db-${BDB_VER}.tar.gz"

LICENSE="PAM"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls elibc_FreeBSD"

RDEPEND="nls? ( virtual/libintl )
	>=sys-libs/pam-0.99.6.3-r1"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
RDEPEND="${RDEPEND}
	>=sys-libs/db-${BDB_VER}"

S="${WORKDIR}/${MY_P}"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${MY_P}-berkdbpam.patch"
	AT_M4DIR="m4" eautoreconf

	elibtoolize
}

src_compile() {
	local myconf

	# don't build documentation as it doesn't seem to really work
	export SGML2PS=no
	export SGML2TXT=no
	export SGML2HTML=no
	export SGML2LATEX=no
	export PS2PDF=no

	if use hppa || use elibc_FreeBSD; then
		myconf="${myconf} --disable-pie"
	fi

	local BDB_DIR="${WORKDIR}/db-${BDB_VER}"

	# BDB is internalized to get a non-threaded lib for pam_userdb.so to
	# be built with.  To demand-load a shared library which uses threads
	# into an application which doesn't is a Very Bad Idea!
	einfo "Building Berkley DB ${BDB_VER}..."
	cd "${BDB_DIR}/build_unix" || die

	CFLAGS="${CFLAGS} -fPIC" \
		ECONF_SOURCE="../dist" \
		econf \
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
		--prefix="${S}/modules/pam_userdb" \
		--includedir="${S}/modules/pam_userdb" \
		--libdir="${S}/modules/pam_userdb" || die "Bad BDB ./configure"

	# XXX: hack out O_DIRECT support in db4 for now.
	#	   (Done above now with --disable-o_direct now)

	emake CC="$(tc-getCC)" || die "BDB build failed"
	emake install || die

	# We link against libdb_pam (*-dbpam.patch), else stupid libtool goes
	# and relinks it during install to libdb in /usr/lib
	cp -f "${S}"/modules/pam_userdb/libdb{,_pam}.a

	# Make sure out static libs are used
	append-flags -I "{S}/modules/pam_userdb"
	append-ldflags -L "${S}/modules/pam_userdb"

	cd "${S}"
	econf \
		$(use_enable nls) \
		--enable-berkdb \
		--enable-securedir=/$(get_libdir)/security \
		--enable-isadir=/$(get_libdir)/security \
		--disable-dependency-tracking \
		--disable-prelude \
		--enable-docdir=/usr/share/doc/${PF} \
		${myconf} || die "econf failed"

	cd "${S}/modules/pam_userdb"
	emake || die "emake failed"
}

src_install() {
	cd "${S}/modules/pam_userdb"
	emake DESTDIR="${D}" install || die "make install failed"

	# No, we don't really need .la files for PAM modules.
	rm -f "${D}/$(get_libdir)/security/"*.la
}
