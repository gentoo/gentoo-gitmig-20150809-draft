# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ruby-mode/ruby-mode-1.8.4.ebuild,v 1.5 2006/12/23 10:16:53 kloeri Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs major mode for editing Ruby code"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/ruby-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
DEPEND="virtual/emacs"

SITEFILE=50ruby-mode-gentoo.el

S="${WORKDIR}/ruby-${PV}/misc"

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ruby-mode *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
