# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv/gnuserv-3.12.5.ebuild,v 1.3 2004/03/04 05:27:25 jhuebel Exp $

inherit elisp

IUSE=""

DESCRIPTION="Gnuserv allows you to attach to an already running Emacs."
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc
	virtual/emacs"

S="${WORKDIR}/${P}"

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

	dodoc ChangeLog COPYING INSTALL README README.orig
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
