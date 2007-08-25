# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.4.0-r6.ebuild,v 1.14 2007/08/25 14:32:47 vapier Exp $

WANT_AUTOMAKE="1.4"
WANT_AUTOCONF="latest"

inherit eutils multilib autotools

MY_P=w3c-${P}
DESCRIPTION="A general-purpose client side WEB API"
HOMEPAGE="http://www.w3.org/Library/"
SRC_URI="http://www.w3.org/Library/Distribution/${MY_P}.tgz
	mirror://gentoo/libwww-5.4.0-debian-autoconf-2.5.patch.bz2"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="mysql ssl"

RDEPEND=">=sys-libs/zlib-1.1.4
	mysql? ( virtual/mysql )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

DEPEND="${RDEPEND}
	dev-lang/perl"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-config-liborder.patch
	epatch "${WORKDIR}"/${P}-debian-autoconf-2.5.patch
	epatch "${FILESDIR}"/${P}-autoconf-gentoo.diff
	epatch "${FILESDIR}"/${P}-automake-gentoo.diff	# bug #41959
	epatch "${FILESDIR}"/${P}-disable-ndebug-gentoo.diff	# bug #50483
	# http://lists.w3.org/Archives/Public/www-lib/2003OctDec/0015.html
	# http://www.mysql.gr.jp/mysqlml/mysql/msg/8118
	epatch "${FILESDIR}"/${P}-mysql-4.0.patch
	# Fix multiple problems, potentially exploitable (bug #109040)
	epatch "${FILESDIR}"/${P}-htbound.patch
	# Fix linking while using --as-needed
	epatch "${FILESDIR}/${P}-asneeded.patch"
	# Drop Externls rebuild after automake
	epatch "${FILESDIR}/${P}-noexport.patch"
	# Respect users LDFLAGS, bug #126863.
	epatch "${FILESDIR}/${P}-respectflags.patch"

	eautoreconf || die "autoreconf failed"
}

src_compile() {
	if use mysql ; then
		myconf="--with-mysql=/usr/$(get_libdir)/mysql/libmysqlclient.a"
	else
		myconf="--without-mysql"
	fi

	export ac_cv_header_appkit_appkit_h=no
	econf \
		--enable-shared \
		--enable-static \
		--with-zlib \
		--with-md5 \
		--with-expat \
		$(use_with ssl) \
		${myconf} || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc ChangeLog
	dohtml -r .
}
