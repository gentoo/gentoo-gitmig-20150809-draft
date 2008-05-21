# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/anubis/anubis-3.9.95.ebuild,v 1.8 2008/05/21 16:02:32 dev-zero Exp $

inherit eutils

DESCRIPTION="GNU Anubis is an outgoing mail processor."
HOMEPAGE="http://www.gnu.org/software/anubis/"

SRC_URI="ftp://mirddin.farlep.net/pub/alpha/anubis/${P}.tar.gz"

# Hasn't propergated much at time of commit.
# SRC_URI="mirror://gnu/anubis/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc"
IUSE="crypt dbm guile mysql postgres nls pam pcre sasl socks5 ssl tcpd"

DEPEND="crypt? ( >=app-crypt/gpgme-0.9.0 )
	dbm? ( sys-libs/gdbm )
	guile? ( >=dev-scheme/guile-1.6 )
	mysql? ( virtual/mysql )
	pam?   ( virtual/pam )
	postgres? ( virtual/postgresql-server )
	nls? ( sys-devel/gettext )
	pcre? ( >=dev-libs/libpcre-3.9 )
	sasl? ( virtual/gsasl )
	ssl?   ( >=dev-libs/openssl-0.9.6 )
	tcpd?  ( >=sys-apps/tcp-wrappers-7.6 )"

# has gnutls=1.0.0 option that is incompatible with ssl

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-transmode.c.patch
	epatch ${FILESDIR}/${PV}-authmode.c.patch
}

src_compile() {
	local myconf="--with-unprivileged-user=anubis"

	use crypt || myconf="${myconf} --without-gpgme"
	if [ -x ${ROOT}/usr/bin/gpg2 ];
	then
		GPG=${ROOT}/usr/bin/gpg2
	else
		GPG=${ROOT}/usr/bin/gpg
	fi

	use ssl  && myconf="${myconf} --with-openssl"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use socks5 && myconf="${myconf} --with-socks-proxy"

	econf ${myconf} `use_with mysql` `use_with postgres` \
		`use_with pam` `use_with pcre` `use_with nls` \
		`use_with guile` `use_with dbm` `use_with sasl gsasl` \
		|| die

	emake -j1 || die
	# parallel make fails in testsuite
}

pkg_setup() {
	enewuser anubis
}

pkg_preinst() {
	enewuser anubis
}

src_test() {
	cd ${S}/testsuite
	emake -j1
}

src_install() {
	emake DESTDIR=${D} install
}
