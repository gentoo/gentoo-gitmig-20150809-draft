# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/courier-authlib/courier-authlib-0.50.20041113.ebuild,v 1.2 2004/11/16 07:44:58 swtaylor Exp $

inherit eutils

DESCRIPTION="courier authentication library"
[ -z "${PV/?.??/}" ] && SRC_URI="mirror://sourceforge/courier-authlib/${P}.tar.bz2" || SRC_URI="http://www.courier-mta.org/beta/courier-authlib/${P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"

SLOT="0"
LICENSE="GPL-2"
#KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64"
KEYWORDS="-*"
IUSE="postgres ldap mysql gdbm pam crypt uclibc debug"

DEPEND="virtual/libc"

RDEPEND="${DEPEND}"

src_unpack() {
	if ! has_version 'dev-tcltk/expect' ; then
		einfo 'The dev-tcltk/expect package is not installed.'
	fi
	unpack ${A}
	cd ${S}
	sed -e"s|^chk_file .* |&\${DESTDIR}|g" -i.orig authmigrate.in
	use uclibc && sed -i -e 's:linux-gnu\*:linux-gnu\*\ \|\ linux-uclibc:' config.sub
}

src_compile() {
	local myconf
	myconf="`use_with pam authpam` `use_with ldap authldap`"
	use gdbm && myconf="${myconf} --with-db=gdbm"

	if [ -f /var/vpopmail/etc/lib_deps ]; then
		myconf="${myconf} --with-authvchkpw --without-authmysql --without-authpgsql"
		use mysql && einfo "vpopmail found. authmysql will not be built."
		use postgres && einfo "vpopmail found. authpgsql will not be built."
	else
		myconf="${myconf} --without-authvchkpw `use_with mysql authmysql` `use_with postgres authpostgres`"
	fi

	use debug && myconf="${myconf} debug=true"

ewarn "${myconf}"

	./configure \
	    --prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier \
		--libexecdir=/usr/lib/courier \
		--datadir=/usr/share/courier \
		--sharedstatedir=/var/lib/courier/com \
		--localstatedir=/var/lib/courier \
		--with-authdaemonvar=/var/lib/courier/authdaemon \
		--with-mailuser=mail \
		--with-mailgroup=mail \
		--cache-file=${S}/configuring.cache \
		--host=${CHOST} ${myconf} || die "bad ./configure"
	emake || die "Compile problem"
}

src_install() {
	dodir /etc/courier/authlib
	dodir /var/lib/courier
	emake install DESTDIR="${D}" || die "install"
	emake install-migrate DESTDIR="${D}" || die "migrate"
	emake install-configure DESTDIR="${D}" || die "configure"
	dodoc AUTHORS COPYING* ChangeLog* INSTALL* NEWS* README*
}

