# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/w3mnav/w3mnav-0.5-r1.ebuild,v 1.2 2004/04/26 09:37:20 dholm Exp $

inherit elisp

DESCRIPTION="w3mnav.el provides Info-like navigation keys to the w3m Web browser."
HOMEPAGE="http://www.neilvandyke.org/w3mnav/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/emacs
	app-emacs/emacs-w3m"
S=${WORKDIR}/${P}

SITEFILE=90w3mnav-gentoo.el

src_compile() {
	echo "(add-to-list 'load-path \"/usr/share/emacs/site-lisp/emacs-w3m\")" >script
	emacs --batch -q --no-site-file --no-init-file \
		-l script -f batch-byte-compile w3mnav.el
}
