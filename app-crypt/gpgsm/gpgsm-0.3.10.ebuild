# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgsm/gpgsm-0.3.10.ebuild,v 1.1 2002/11/01 10:29:43 aliz Exp $

S="${WORKDIR}/newpg-${PV}"
DESCRIPTION="GnuPG Cryptographic message syntax and temporary project for gnupg extensions. Will be merged into gnupg for the gnupg-2.0 release."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/aegypten/newpg-${PV}.tar.gz"
HOMEPAGE="http://www.gnupg.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-libs/libgcrypt-1.1.8
	>=dev-libs/libksba-0.4.4
	>=dev-libs/pth-1.3.7"

#pth isn't really necessary, but is a good thing
#maybe a threads use variable?
#this can also be built with smartcard support, but we have no ebuilds or use vars for that

RDEPEND="nls? ( sys-devel/gettext )"

src_compile(){
	local myconf
	use nls \
		|| myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS README README-alpha THANKS TODO VERSION
}
