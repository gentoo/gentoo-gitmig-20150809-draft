# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ddskk/ddskk-12.2.0.ebuild,v 1.1 2003/08/03 18:06:42 usata Exp $

inherit elisp

IUSE=""

MY_P=${PN}-${PV/_/}

DESCRIPTION="SKK is one of Japanese input methods on Emacs"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/${MY_P}.tar.bz2"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~sparc ~ppc"
SLOT="0"

DEPEND=">=sys-apps/sed-4
	app-emacs/apel
	virtual/emacs"
RDEPEND="virtual/emacs
	app-emacs/apel
	virtual/skkserv"

SITEFILE=50ddskkserv-gentoo.el

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${A}
	cp ${FILESDIR}/${SITEFILE} ${SITEFILE/serv/}
	find . -type f | xargs sed -i -e 's%/usr/local%/usr%g'
}

src_compile() {

	make < /dev/null || die
	make info < /dev/null || die
}

src_install () {

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${WORKDIR}/${SITEFILE/serv/} || die

	insinto /usr/share/skk
	doins etc/SKK.tut etc/SKK.tut.E etc/NICOLA-SKK.tut etc/skk.xpm

	dodoc READMEs/* ChangeLog*

	# prohibit gzipping info files
	make SKK_INFODIR=${D}/usr/share/info install-info < /dev/null || die
}

prepall () {

	einfo "SKK info files should not be gzipped"
}
