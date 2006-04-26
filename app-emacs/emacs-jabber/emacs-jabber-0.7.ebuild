# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-jabber/emacs-jabber-0.7.ebuild,v 1.1 2006/04/26 16:06:41 mkennedy Exp $

inherit distutils elisp

IUSE="sasl"

DESCRIPTION="A Jabber client for Emacs."
HOMEPAGE="http://emacs-jabber.sourceforge.net/
	http://emacswiki.org/cgi-bin/wiki/JabberEl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

# emacs-jabber depends on >= gnus-5.10 which is available in
# app-emacs/gnus or bundled with app-editors/emacs-cvs.	 emacs 21.4a
# includes gnus-5.9

DEPEND="sys-apps/texinfo
	|| ( app-emacs/gnus app-editors/emacs-cvs )
	sasl? ( app-emacs/flim )"

SITEFILE="70emacs-jabber-gentoo.el"

src_unpack() {
	unpack ${A}
	rm ${S}/{sha1,hex-util}.el
}
src_compile() {
	elisp-comp *.el || die
	makeinfo jabber.texi || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	doinfo jabber.info
	dohtml html/*
	dodoc AUTHORS NEWS README
}
