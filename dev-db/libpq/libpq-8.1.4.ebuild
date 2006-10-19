# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libpq/libpq-8.1.4.ebuild,v 1.5 2006/10/19 16:14:05 uberlord Exp $

inherit eutils gnuconfig flag-o-matic toolchain-funcs

DESCRIPTION="Libraries of postgresql"
HOMEPAGE="http://www.postgresql.org/"
MY_P="postgresql-${PV}"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-base-${PV}.tar.bz2
	mirror://postgresql/source/v${PV}/postgresql-opt-${PV}.tar.bz2"

LICENSE="POSTGRESQL"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="ssl nls pam readline zlib kerberos threads"

S=${WORKDIR}/${MY_P}
DEPEND="virtual/libc
	sys-devel/autoconf
	>=sys-libs/ncurses-5.2
	>=sys-devel/bison-1.875
	zlib? ( >=sys-libs/zlib-1.1.3 )
	pam? ( virtual/pam )
	readline? ( >=sys-libs/readline-4.1 )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	nls? ( sys-devel/gettext )
	kerberos? ( virtual/krb5 )"
RDEPEND="virtual/libc
	zlib? ( >=sys-libs/zlib-1.1.3 )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	kerberos? ( virtual/krb5 )"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_preinst() {
	# removing wrong symlink which is created by previous ebuild.
	if [ -L ${ROOT}/usr/include/libpq ]; then
		rm ${ROOT}/usr/include/libpq
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	filter-flags -ffast-math -feliminate-dwarf2-dups

	local myconf
	use ssl && myconf="$myconf --with-openssl"
	use nls && myconf="$myconf --enable-nls"
	use pam && myconf="$myconf --with-pam"
	use readline || myconf="$myconf --without-readline"
	use zlib || myconf="$myconf --without-zlib"
	use kerberos && myconf="$myconf --with-krb5"
	use threads && myconf="$myconf --enable-thread-safety"

	# these are the only working CFLAGS I could get on ppc, so locking them
	# down, anything more aggressive fails (i.e. -mcpu or -Ox)
	# Gerk - Nov 26, 2002
	use ppc && CFLAGS="-pipe -fsigned-char"

	# Detect mips systems properly
	gnuconfig_update

	./configure --prefix=/usr \
		--include=/usr/include/postgresql/libpq-${SLOT} \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--with-docdir=/usr/share/doc/${PF} \
		--libdir=/usr/$(get_libdir) \
		--enable-depend \
		$myconf || die

	cd ${S}/src/interfaces/libpq
	emake LD="$(tc-getLD) $(get_abi_LDFLAGS)" || die
}

src_install() {
	cd ${S}/src/interfaces/libpq
	make DESTDIR=${D} LIBDIR=${D}/usr/$(get_libdir) install || die

	cd ${S}/src/include
	make DESTDIR=${D} install || die

	cd ${S}
	dodoc README HISTORY COPYRIGHT INSTALL

	dosym libpq-${SLOT}.a /usr/$(get_libdir)/libpq.a

	for f in ${D}/usr/include/postgresql/libpq-${SLOT}/*.h
	do
		dosym postgresql/libpq-${SLOT}/$(basename $f) /usr/include/
	done

	dodir /usr/include/libpq
	for f in ${D}/usr/include/postgresql/libpq-${SLOT}/libpq/*.h
	do
		dosym ../postgresql/libpq-${SLOT}/libpq/$(basename $f) /usr/include/libpq/
	done

	cd ${D}/usr/include/postgresql/libpq-${SLOT}
	for f in $(find * -name '*.h' -print) ; do
		destdir=$(dirname $f)
		if [ ! -d "${D}/usr/include/postgresql/${destdir}" ]; then
			dodir /usr/include/postgresql/${destdir}
		fi
		dosym /usr/include/postgresql/libpq-${SLOT}/${f} /usr/include/postgresql/${destdir}/
	done
}
