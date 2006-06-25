# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tnt/tnt-2.6.ebuild,v 1.1 2006/06/25 17:38:00 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Client for the AOL Instant Messenging service using the Emacs text editor as it's UI."
HOMEPAGE="http://tnt.sourceforge.net/"
SRC_URI="mirror://sourceforge/tnt/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/emacs"

src_compile() {
	elisp-comp *.el
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/51tnt-gentoo.el
	insinto $SITELISP/tnt/sounds
	doins sounds/*
	dodoc ChangeLog INSTALL PROTOCOL README
	insinto /usr/share/doc/${PF}/procmail
	doins procmail/*
}
