# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libpq/libpq-3.2.ebuild,v 1.3 2005/05/09 21:38:07 nakano Exp $

inherit eutils gnuconfig flag-o-matic multilib toolchain-funcs

DESCRIPTION="Libraries of postgresql"
HOMEPAGE="http://www.postgresql.org/"
MY_PV=${PV/_/}
POSTGRESQL_VER="8.0.1"
MY_P="postgresql"-${POSTGRESQL_VER}
SRC_URI="mirror://postgresql/source/v${POSTGRESQL_VER}/postgresql-base-${POSTGRESQL_VER}.tar.bz2"

LICENSE="POSTGRESQL"
SLOT="3"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE="ssl nls pam readline zlib kerberos"
#pg-hier"

S=${WORKDIR}/${MY_P}
DEPEND="virtual/libc
	sys-devel/autoconf
	>=sys-libs/ncurses-5.2
	>=sys-devel/bison-1.875
	zlib? ( >=sys-libs/zlib-1.1.3 )
	readline? ( >=sys-libs/readline-4.1 )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	nls? ( sys-devel/gettext )
	kerberos? ( virtual/krb5 )"
RDEPEND="virtual/libc
	zlib? ( >=sys-libs/zlib-1.1.3 )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	kerberos? ( virtual/krb5 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
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
		--with-gnu-ld \
		$myconf || die

	cd ${S}/src/interfaces/libpq
	make LD="$(tc-getLD) $(get_abi_LDFLAGS)" || die
}

src_install() {
	cd ${S}/src/interfaces/libpq
	make DESTDIR=${D} LIBDIR=${D}/usr/lib install || die

	cd ${S}/src/include
	make DESTDIR=${D} install || die

	cd ${S}
	dodoc README HISTORY COPYRIGHT INSTALL

	dosym /usr/lib/libpq-${SLOT}.a /usr/lib/libpq.a

	ln -s ${D}/usr/include/postgresql/libpq-${SLOT}/*.h ${D}/usr/include/

	dodir /usr/include/libpq
	ln -s ${D}/usr/include/postgresql/libpq-${SLOT}/libpq/*.h ${D}/usr/include/libpq

	cd ${D}/usr/include/postgresql/libpq-${SLOT}
	for f in $(find . -name '*.h' -print) ; do
		destdir=$(dirname $f)
		if [ ! -d "${D}/usr/include/postgresql/${destdir}" ]; then
			mkdir -p ${D}/usr/include/postgresql/${destdir}
		fi
		ln -s ${D}/usr/include/postgresql/libpq-${SLOT}/${f} ${D}/usr/include/postgresql/${destdir}/
	done
}
