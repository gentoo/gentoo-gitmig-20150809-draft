# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv/gnuserv-3.12.4.ebuild,v 1.4 2004/06/01 14:09:04 vapier Exp $

inherit elisp

DESCRIPTION="Gnuserv allows you to attach to an already running Emacs"
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/OLD/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc
	virtual/emacs"

SITEFILE=50gnuserv-gentoo.el

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	dodir /usr/share/man/man1
	make prefix=${D}/usr \
		man1dir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install || die

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc ChangeLog INSTALL README README.orig
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
