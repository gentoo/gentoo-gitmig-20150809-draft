# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tramp/tramp-2.0.36.ebuild,v 1.1 2003/08/04 01:16:55 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="TRAMP (Transparent Remote Access, Multiple Protocols) is a package for editing remote files, similar to ange-ftp. Whereas ange-ftp uses FTP to connect to the remote host and to transfer the files, TRAMP uses a remote shell connection (rlogin, telnet, ssh)"
HOMEPAGE="http://savannah.nongnu.org/projects/tramp/"
#SRC_URI="mirror://gentoo/${P}.tar.gz"
SRC_URI="http://savannah.nongnu.org/download/tramp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

src_compile() {
	econf
	emake || die "compile problem"
}

src_install() {
	dodir /usr/share/emacs/site-lisp/tramp
	dodir /usr/share/info
	dodir /usr/share/emacs/etc

	make install \
	prefix=${D}/usr \
	datadir=${D}/usr/share \
	infodir=${D}/usr/share/info \
	lispdir=${D}/usr/share/emacs/site-lisp/tramp \
	etcdir=${D}/usr/share/emacs/etc \
	|| die

	mv ${D}/usr/share/info/tramp ${D}/usr/share/info/tramp-info

	dohtml texi/*.html

	elisp-site-file-install ${FILESDIR}/50tramp-gentoo.el

	dodoc README ChangeLog CONTRIBUTORS
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
