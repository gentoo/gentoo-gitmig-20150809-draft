# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tramp/tramp-20020411.ebuild,v 1.3 2003/09/06 22:01:26 msterret Exp $

inherit elisp

IUSE=""

DESCRIPTION="TRAMP (Transparent Remote Access, Multiple Protocols) is a package for editing remote files, similar to ange-ftp. Whereas ange-ftp uses FTP to connect to the remote host and to transfer the files, TRAMP uses a remote shell connection (rlogin, telnet, ssh"
HOMEPAGE="http://tramp.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${PN}"

src_compile() {
	make EMACS=emacs all || die
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install ${FILESDIR}/50tramp-gentoo.el

	dodoc README ChangeLog.orig ChangeLog CONTRIBUTORS
	doinfo texi/tramp.info
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
