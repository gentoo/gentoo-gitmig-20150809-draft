# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qemacs/qemacs-0.3.1-r1.ebuild,v 1.1 2005/02/20 11:45:33 usata Exp $

inherit eutils

DESCRIPTION="QEmacs (for Quick Emacs) is a very small but powerful UNIX editor."
HOMEPAGE="http://fabrice.bellard.free.fr/qemacs/"
SRC_URI="http://fabrice.bellard.free.fr/qemacs/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="X png unicode"

DEPEND="X? ( virtual/x11 )
	png? ( =media-libs/libpng-1.2* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/qemacs-Makefile-gentoo.patch
	epatch ${FILESDIR}/${P}-configure-gentoo.patch
	epatch ${FILESDIR}/${P}-make_backup.patch
	use unicode && epatch ${FILESDIR}/${P}-tty_utf8.patch
}

src_compile() {
	local myconf
	use X && myconf="--enable-x11" || myconf="--disable-x11"
	use png && myconf="${myconf} --enable-png" || myconf="${myconf} --disable-png"
	econf ${myconf} || die "econf failed"
	emake -j1 || die
}

src_install() {
	dodir /usr/bin
	einstall || die
	doman qe.1
	dodoc Changelog README TODO VERSION
	dohtml *.html
}
