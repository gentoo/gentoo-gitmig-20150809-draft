# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.3-r1.ebuild,v 1.2 2003/09/06 22:15:09 msterret Exp $

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~sparc"
IUSE="X zlib ldap nls"

DEPEND="dev-lang/perl
	X? ( x11-misc/xloadimage )
	zlib? ( sys-libs/zlib )
	ldap? ( net-nds/openldap )"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable ldap`"
	myconf="${myconf} `use_enable X photo-viewers`"
	myconf="${myconf} `use_with zlib included-zlib`"

	# Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	if ! use sparc; then
		myconf="${myconf} --enable-m-guard"
	fi

	econf ${myconf} \
		--libexecdir=/usr/lib/gnupg \
		--enable-external-hkp || die "configure failed"
	emake || die "compile problem"
}

src_install() {
	einstall libexecdir="${D}/usr/lib/gnupg" || die

	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS PROJECTS README \
			THANKS TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

	docinto sgml
	dodoc doc/*.sgml

	dohtml doc/faq.html

	chmod u+s "${D}/usr/bin/gpg"
}

pkg_postinst() {
	einfo "gpg is installed SUID root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your passphrases,"
	einfo "etc. at runtime but may make some sysadmins nervous"
}
