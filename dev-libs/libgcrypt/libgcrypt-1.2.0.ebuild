# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.2.0.ebuild,v 1.13 2004/10/23 06:25:55 mr_bones_ Exp $

DESCRIPTION="general purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/libgcrypt/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 sparc ~mips ~alpha hppa ia64 ~ppc ppc64 ppc-macos"
IUSE="nls"

DEPEND="dev-libs/libgpg-error"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) --disable-dependency-tracking || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING* NEWS README* THANKS TODO VERSION

	# backwards compat symlinks
	if ! ( use macos || use ppc-macos ) ; then
		dosym libgcrypt.so.11 /usr/lib/libgcrypt.so.7
		dosym libgcrypt-pth.so.11 /usr/lib/libgcrypt-pth.so.7
		dosym libgcrypt-pthread.so.11 /usr/lib/libgcrypt-pthread.so.7
	fi
}
