# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.3-r3.ebuild,v 1.1 2003/10/31 15:46:04 taviso Exp $

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~sparc ~hppa"
IUSE="X ldap nls static cap"

RDEPEND="!static? ( ldap? ( net-nds/openldap )
		cap? ( sys-libs/libcap )
		sys-libs/zlib )
	X? ( x11-misc/xloadimage )
	nls? ( sys-devel/gettext )"

DEPEND="cap? ( static? ( >=sys-libs/libcap-1.10-r3 )
		!static? ( sys-libs/libcap ) )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	!static? ( sys-libs/zlib )
	dev-lang/perl"

src_compile() {
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
	# the included zlib library and remove a dep.
	# `USE=static` support was requested in #29299
	if use static; then
		myconf="${myconf} --with-included-zlib"
		LDFLAGS="${LDFLAGS} -static"
	else
		myconf="${myconf} --without-included-zlib"
	fi

	# use the linux capability library to minimise security
	# risks of running setuid root.
	if use cap; then
		myconf="${myconf} --with-capabilities"
	fi

	# Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	if ! use sparc; then
		myconf="${myconf} --enable-m-guard"
	fi

	econf ${myconf}
	emake
}

src_install() {
	einstall libexecdir="${D}/usr/lib/gnupg"

	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS PROJECTS \
	README THANKS TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

	docinto sgml
	dodoc doc/*.sgml

	dohtml doc/faq.html

	chmod u+s "${D}/usr/bin/gpg"
}

pkg_postinst() {
	einfo "gpg is installed suid root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your"
	einfo "passphrases, etc. This may make some sysadmins nervous."

	if use cap; then
		echo
		einfo "gpg will use Linux capabilities to set the permitted"
		einfo "operations, this will minimise the security risks"
		einfo "associated with running setuid root."
		echo
		einfo "You can confirm the capabilities are being set correctly"
		einfo "with the following command while gpg is running"
		echo
		einfo "	# getpcaps \`pidof gpg\`"
	fi
}
