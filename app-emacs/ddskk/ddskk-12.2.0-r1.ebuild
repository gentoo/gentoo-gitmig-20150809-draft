# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ddskk/ddskk-12.2.0-r1.ebuild,v 1.7 2008/01/09 15:26:44 ulm Exp $

inherit elisp

MY_P=${PN}-${PV/_/}

DESCRIPTION="SKK is one of Japanese input methods on Emacs"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc"
IUSE=""

DEPEND=">=sys-apps/sed-4
	>=app-emacs/apel-10.6"
RDEPEND=">=app-emacs/apel-10.6
	|| ( virtual/skkserv app-i18n/skk-jisyo )"

SITEFILE=50ddskk-gentoo.el

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	find . -type f | xargs sed -i -e 's%/usr/local%/usr%g'
}

src_compile() {
	make < /dev/null || die
	make info < /dev/null || die
}

src_install () {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	insinto /usr/share/skk
	doins etc/*SKK.tut* etc/skk.xpm

	dodoc READMEs/* ChangeLog*
	doinfo doc/skk.info*
}
