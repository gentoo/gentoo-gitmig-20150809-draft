# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.9.0.ebuild,v 1.1 2004/01/06 17:46:23 taviso Exp $

inherit eutils

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gnupg/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"

# IDEA license is rather restrictive if you're unlucky enough to
# live in a country where its patented, however it is FAIB for
# non-commercial use.
use idea && LICENCE="${LICENCE} | IDEA"

KEYWORDS="~x86 ~alpha"
IUSE="X ldap nls caps"

RDEPEND="!static? ( ldap? ( net-nds/openldap )
		caps? ( sys-libs/libcap )
		sys-libs/zlib )
	X? ( x11-misc/xloadimage )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.42
	>=dev-libs/libksba-0.4.7
	virtual/glibc
	dev-lang/perl
	dev-libs/pth
	virtual/mta"

DEPEND="caps? ( sys-libs/libcap )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.42
	>=dev-libs/libksba-0.4.7
	dev-libs/libassuan
	sys-libs/zlib
	virtual/glibc
	dev-lang/perl
	dev-libs/pth"

src_compile() {
	local myconf="--libexecdir=/usr/lib"

	if ! use nls; then
		myconf="${myconf} --disable-nls"
	fi

	if use ldap; then
		myconf="${myconf} --enable-ldap"
	else
		myconf="${myconf} --disable-ldap"
	fi

	if use X; then
		myconf="${myconf} --with-photo-viewer=/usr/bin/xloadimage"
	else
		myconf="${myconf} --disable-photo-viewers"
	fi

	if use caps; then
		myconf="${myconf} --with-capabilities"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall libexecdir="${D}/usr/lib/gnupg"

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS \
	README THANKS TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

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
	echo
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
	ewarn "	THIS IS _ALPHA_ CODE, IT MAY NOT WORK CORRECTLY OR AT ALL. THERE"
	ewarn "	MAY BE SECURITY PROBLEMS, DO NOT USE IN A PRODUCTION ENVIRONMENT."
	ewarn ""
	ewarn "	This ebuild is provided for those who wish to experiment with this"
	ewarn "	new branch of gnupg and beta-testers, not for general purpose use"
	ewarn "	by non-developers"
	ewarn ""
	ewarn "	Please see #37109"
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
}
