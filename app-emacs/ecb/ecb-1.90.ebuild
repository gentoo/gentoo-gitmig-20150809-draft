# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ecb/ecb-1.90.ebuild,v 1.4 2003/06/29 19:00:22 aliz Exp $

inherit elisp

IUSE=""

DESCRIPTION="ECB is source code browser for Emacs. It is a global minor-mode which displays a couple of windows that can be used to browse directories, files and methods. It supports method parsing for Java, C, C++, Elisp etc."
HOMEPAGE="http://home.swipnet.se/mayhem/ecb.html"
SRC_URI="mirror://sourceforge/ecb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	app-emacs/speedbar
	app-emacs/eieio
	app-emacs/jde
	app-emacs/elib"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
 	cd ${S} && patch -p1 <${FILESDIR}/${P}-gentoo.patch || die
 	sed -e "s,@ECB_INFO@,/usr/share/info/ecb.info.gz,g" <ecb-help.el >ecb-help.el.new && \
 		mv ecb-help.el.new ecb-help.el
 	sed -e "s,@ECB_HTML@,/usr/share/doc/${P}/html/ecb.html,g" <ecb-help.el >ecb-help.el.new && \
 		mv ecb-help.el.new ecb-help.el
}

src_compile() {
	make LOADPATH="${SITELISP}/elib ${SITELISP}/semantic ${SITELISP}/eieio ${SITELISP}/jde/lisp" || die
}

src_install() {
 	elisp-install ${PN} *.el *.elc
 	elisp-site-file-install ${FILESDIR}/50ecb-gentoo.el
	dodoc HISTORY README RELEASE_NOTES
	makeinfo --force ecb.texi
	doinfo ecb.info*
	dohtml ecb.html
}

pkg_postinst() {
	elisp-site-regen
	einfo ""
	einfo "To start ECB:"
	einfo "	M-x ecb-activate"
	einfo ""
}

pkg_postrm() {
	elisp-site-regen
}
