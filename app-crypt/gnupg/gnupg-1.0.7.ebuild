# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.0.7.ebuild,v 1.16 2003/02/13 06:14:21 vapier Exp $

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/pub/gcrypt/gnupg/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "
IUSE="nls"

DEPEND=">=sys-libs/zlib-1.1.3"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# Fix those $&*%^$%%$ info files
	patch -p1 < "${FILESDIR}/gnupg-1.0.6.diff"
}

src_compile() {
	local myconf="--enable-static-rnd=linux"
	use nls || myconf="--disable-nls"

	# Bug #6387, --enable-m-guard causes bus error on sparcs
	if [ "${ARCH}" != "sparc" -a "${ARCH}" != "" ]; then
		myconf="${myconf} --enable-m-guard"
	fi
	econf ${myconf}

	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS PROJECTS
	dodoc README TODO VERSION
	docinto doc
	cd doc
	dodoc  FAQ HACKING DETAILS ChangeLog
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
	echo  " "
	einfo "Note: this version is not backwards compatible with gnupg-1.0.6."
	einfo "	  To update your keyrings run: gpg --rebuild-keydb-caches"
	einfo "	  To backup your keyrings run: gpg --export-ownertrust"
	einfo "	  and copy the keyrings out of your ~/.gnupg directory."
}
