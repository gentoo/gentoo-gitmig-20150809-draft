# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ruby-mode/ruby-mode-1.8.1.ebuild,v 1.1 2004/01/11 18:51:13 usata Exp $

inherit elisp

DESCRIPTION="Emacs major mode for editing Ruby code"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/ruby-${PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86"
LICENSE="GPL-2"
DEPEND="virtual/emacs"

SITEFILE=50ruby-mode-gentoo.el

S="${WORKDIR}/ruby-${PV}/misc"

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ruby-mode *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
