# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ddskk/ddskk-12.2.1_pre20050522.ebuild,v 1.3 2007/07/03 06:57:07 opfer Exp $

inherit elisp

IUSE=""

MY_P="${PN}-${PV/*_pre/}"

DESCRIPTION="One Japanese input methods on Emacs"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~sparc ~x86"
SLOT="0"

DEPEND=">=app-emacs/apel-10.6"
RDEPEND="${RDEPEND}
	|| ( virtual/skkserv app-i18n/skk-jisyo )"

SITEFILE=50ddskk-gentoo.el

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${A}
	find . -type f | xargs sed -i -e 's%/usr/local%/usr%g'
}

src_compile() {

	emake < /dev/null || die "emake failed"
	emake info < /dev/null || die "emake info failed"
	#cd nicola
	#make < /dev/null || die
	cd "${S}/tut-code"
	elisp-compile *.el
}

src_install () {

	elisp-install ${PN} *.el* nicola/*.el* tut-code/*.el*
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die "elisp-site-file-install failed"

	insinto /usr/share/skk
	doins etc/*SKK.tut* etc/skk.xpm

	dodoc READMEs/* ChangeLog*
	doinfo doc/skk.info*

	#docinto nicola
	#dodoc nicola/ChangeLog* nicola/README*
	docinto tut-code
	dodoc tut-code/README.tut
}
