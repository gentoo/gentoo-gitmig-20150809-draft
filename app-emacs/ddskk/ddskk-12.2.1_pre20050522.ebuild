# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ddskk/ddskk-12.2.1_pre20050522.ebuild,v 1.2 2005/07/01 18:14:57 mkennedy Exp $

inherit elisp

IUSE=""

MY_P="${PN}-${PV/*_pre/}"

DESCRIPTION="SKK is one of Japanese input methods on Emacs"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~sparc ~x86"
SLOT="0"

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
	#cd nicola
	#make < /dev/null || die
	cd ${S}/tut-code
	elisp-compile *.el
}

src_install () {

	elisp-install ${PN} *.el* nicola/*.el* tut-code/*.el*
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	insinto /usr/share/skk
	doins etc/*SKK.tut* etc/skk.xpm

	dodoc READMEs/* ChangeLog*
	doinfo doc/skk.info*

	#docinto nicola
	#dodoc nicola/ChangeLog* nicola/README*
	docinto tut-code
	dodoc tut-code/README.tut
}
