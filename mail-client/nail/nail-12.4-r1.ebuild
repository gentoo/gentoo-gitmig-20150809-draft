# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/nail/nail-12.4-r1.ebuild,v 1.1 2010/07/26 22:50:28 flameeyes Exp $

EAPI="3"

inherit eutils toolchain-funcs

HOMEPAGE="http://heirloom.sourceforge.net/"
DESCRIPTION="an enhanced mailx-compatible mail client"
LICENSE="BSD"

MY_PN="mailx"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/project/heirloom/heirloom-${MY_PN}/${PV}/${MY_P}.tar.bz2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-freebsd ~x86-interix"
IUSE="ssl net kerberos"

PROVIDE="virtual/mailx"
RDEPEND="
	net? (
		ssl? ( dev-libs/openssl )
		kerberos? ( virtual/krb5 )
	)
	!virtual/mailx
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

undef() {
	sed -i -e "/$1/s:#define:#undef:" config.h || die
}

droplib() {
	sed -i -e "/$1/s:^:#:" LIBS || die
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-debian.patch \
		"${FILESDIR}"/${P}-openssl-1.patch
	# Do not strip the binary
	sed -i -e '/STRIP/d' Makefile
}

src_configure() {
	# Build config.h and LIBS, neccesary to tweak the config
	make config.h LIBS

	# Logic to 'configure' the package

	if ! use ssl || ! use net ; then
		undef 'USE_\(OPEN\)\?SSL'
		droplib -lssl
	fi

	if ! use kerberos || ! use net ; then
		undef 'USE_GSSAPI'
		droplib -lgssapi_krb5
	fi

	if ! use net ; then
		undef 'HAVE_SOCKETS'
	fi
}

src_compile() {
	# No configure script to check for and set this
	tc-export CC

	emake \
		CPPFLAGS="${CPPFLAGS} -D_GNU_SOURCE"
		PREFIX="${EPREFIX}"/usr SYSCONFDIR="${EPREFIX}"/etc \
		MAILSPOOL='/var/spool/mail' \
		|| die "emake failed"
}

src_install () {
	# Use /usr/lib/sendmail by default and provide an example
	cat <<- EOSMTP >> nail.rc

		# Use the local sendmail (/usr/lib/sendmail) binary by default.
		# (Uncomment the following line to use a SMTP server)
		#set smtp=localhost
	EOSMTP

	make DESTDIR="${D}" \
		UCBINSTALL=$(type -p install) \
		PREFIX="${EPREFIX}"/usr SYSCONFDIR="${EPREFIX}"/etc install \
		|| die
	dodoc AUTHORS README
	dodir /bin
	dosym /usr/bin/mailx /bin/mail
	dosym /usr/bin/mailx /usr/bin/mail
	dosym /usr/bin/mailx /usr/bin/Mail
}
