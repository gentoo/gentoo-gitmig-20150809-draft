# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.3-r3.ebuild,v 1.6 2003/11/12 22:17:30 taviso Exp $

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~sparc ~hppa"
IUSE="X ldap nls static caps"

# gpgkeys_mailto requires perl and sendmail,
# depend on virtual/mta (ssmtp does just fine).
RDEPEND="!static? ( ldap? ( net-nds/openldap )
		caps? ( sys-libs/libcap )
		sys-libs/zlib )
	X? ( x11-misc/xloadimage )
	nls? ( sys-devel/gettext )
	virtual/glibc
	dev-lang/perl
	virtual/mta"

# libpcap earlier than 1.10-r3 did not provide
# libcap.a, and therefore cannot be compiled
# statically. >=sys-libs/libcap-1.10-r3 fixes.
DEPEND="caps? ( static? ( >=sys-libs/libcap-1.10-r3 )
		!static? ( sys-libs/libcap ) )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	!static? ( sys-libs/zlib )
	virtual/glibc
	dev-lang/perl"

src_compile() {
	# support for external HKP keyservers requested in #16457.
	# gpg faq entry 3.3 reccommends using --enable-static-rnd=linux 
	# whenever possible.
	local myconf="--enable-external-hkp --enable-static-rnd=linux --libexecdir=/usr/lib"

	# disable native language support
	if ! use nls; then
		myconf="${myconf} --disable-nls"
	fi

	# enable LDAP keyserver interface
	if use ldap; then
		myconf="${myconf} --enable-ldap"
	else
		myconf="${myconf} --disable-ldap"
	fi

	# enable photo ID viewers
	# TODO: optional image viewer? --with-photo-viewer=...
	if use X; then
		myconf="${myconf} --enable-photo-viewers"
	else
		myconf="${myconf} --disable-photo-viewers"
	fi

	# if we are compiling statically, we might as well use
	# the included zlib library and remove an rdep/dep.

	# `USE=static` support was requested in #29299
	if use static; then
		myconf="${myconf} --with-included-zlib"
		export LDFLAGS="${LDFLAGS} -static"
	else
		myconf="${myconf} --without-included-zlib"
	fi

	# use the linux capability library to minimise security
	# risks of running setuid root.
	# see the capabilities(7) manpage.
	if use caps; then
		myconf="${myconf} --with-capabilities"
	fi

	# Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	if ! use sparc; then
		myconf="${myconf} --enable-m-guard"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall libexecdir="${D}/usr/lib/gnupg"

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS PROJECTS \
	README THANKS TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

	docinto sgml
	dodoc doc/*.sgml

	dohtml doc/faq.html

	# please see glsa 200307-06
	if ! use caps; then
		chmod u+s "${D}/usr/bin/gpg"
	fi
}

pkg_postinst() {
	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
}
