# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.2.ebuild,v 1.2 2003/05/14 07:56:16 aliz Exp $

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha arm"
IUSE="X zlib ldap nls"

DEPEND="dev-lang/perl
	X? ( x11-misc/xloadimage )
	zlib? ( sys-libs/zlib )
	ldap? ( net-nds/openldap )"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use ldap || myconf="${myconf} --disable-ldap"
	use zlib || myconf="${myconf} --with-included-zlib"
	use X || myconf="${myconf} --disable-photo-viewers"

	#Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	if [ "${ARCH}" != "sparc" -a "${ARCH}" != "sparc64" ]; then
		myconf="${myconf} --enable-m-guard"
	fi

	econf ${myconf}
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS PROJECTS README THANKS TODO VERSION
	docinto doc
	cd doc
	dodoc FAQ HACKING DETAILS ChangeLog OpenPGP
	docinto sgml
	dodoc gpg.sgml gpgv.sgml
	dohtml faq.html
	docinto txt
	dodoc faq.raw
	chmod +s "${D}/usr/bin/gpg"
}

pkg_postinst() {
	einfo "gpg is installed SUID root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your passphrases,"
	einfo "etc. at runtime but may make some sysadmins nervous"
}
