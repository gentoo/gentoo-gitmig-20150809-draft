# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-jabber/emacs-jabber-0.7-r1.ebuild,v 1.4 2007/07/02 14:20:19 ulm Exp $

inherit elisp

DESCRIPTION="A Jabber client for Emacs"
HOMEPAGE="http://emacs-jabber.sourceforge.net/
	http://emacswiki.org/cgi-bin/wiki/JabberEl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE="sasl"

# emacs-jabber depends on >= gnus-5.10 which is available in
# app-emacs/gnus or bundled with app-editors/emacs-cvs.	 emacs 21.4a
# includes gnus-5.9

DEPEND=">=virtual/gnus-5.10
	sasl? ( app-emacs/flim )"
RDEPEND="${DEPEND}"

SITEFILE=70${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	rm "${S}"/{sha1,hex-util}.el
	use sasl || rm "${S}/jabber-sasl.el"
}
src_compile() {
	elisp-comp *.el || die "elisp-comp failed"
	makeinfo jabber.texi || die "makeinfo failed"
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo jabber.info
	dohtml html/*
	dodoc AUTHORS NEWS README || die "dodoc failed"
}
