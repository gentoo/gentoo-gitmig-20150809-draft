# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/newpg/newpg-0.9.4.ebuild,v 1.7 2004/05/31 20:34:34 vapier Exp $

DESCRIPTION="NewPG is the S/MIME variant of GnuPG which does also include the gpg-agent, useful even for GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/aegypten/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND="dev-lang/perl
	>=dev-libs/libksba-0.4.6
	>=dev-libs/libgcrypt-1.1.8
	dev-libs/pth"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} --disable-dependency-tracking || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO VERSION

	chmod +s "${D}/usr/bin/gpgsm"
}

pkg_postinst() {
	einfo "gpgsm is installed SUID root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your passphrases,"
	einfo "etc. at runtime but may make some sysadmins nervous"
}
