# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbiff/wmbiff-0.4.17.ebuild,v 1.1 2003/12/18 12:45:19 phosphan Exp $

DESCRIPTION="WMBiff is a dock applet for WindowMaker which can monitor up to 5 mailboxes."
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"

DEPEND="virtual/x11
		crypt? ( net-libs/gnutls
			dev-libs/libgcrypt )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="crypt"

src_compile() {
	local myconf
	if ! use crypt; then # disabling does not work properly
		if has_version net-libs/gnutls; then
			myconf="--with-libgnutls-prefix=/this/does/not/exist"
		fi
		if has_version dev-libs/libgcrypt; then
			myconf="${myconf} --with-libgcrypt-prefix=/this/does/not/exist"
		fi
	fi
	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog  FAQ NEWS  README  README.licq  TODO
}
