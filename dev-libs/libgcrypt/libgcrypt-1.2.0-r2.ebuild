# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.2.0-r2.ebuild,v 1.6 2005/03/26 20:54:25 vanquirius Exp $

inherit eutils

DESCRIPTION="general purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/libgcrypt/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 sparc ~x86"
IUSE="nls"

DEPEND="dev-libs/libgpg-error"
RDEPEND="nls? ( sys-devel/gettext )
	dev-libs/libgpg-error"

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${PN}-hppa.patch
	use sparc && epatch ${FILESDIR}/${PN}-rijndael.patch

}

src_compile() {
	econf $(use_enable nls) --disable-dependency-tracking || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING* NEWS README* THANKS TODO VERSION

	# backwards compat symlinks
	if ! use ppc-macos
	then
		dosym libgcrypt.so.11 /usr/lib/libgcrypt.so.7
		dosym libgcrypt-pth.so.11 /usr/lib/libgcrypt-pth.so.7
		dosym libgcrypt-pthread.so.11 /usr/lib/libgcrypt-pthread.so.7
	fi
}
