# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/preview-latex/preview-latex-0.7.8.ebuild,v 1.1 2004/02/01 08:05:44 usata Exp $

inherit latex-package elisp-common

DESCRIPTION="Renders embed latex environments such as math or figures in realtime"
HOMEPAGE="http://preview-latex.sourceforge.net/"
SRC_URI="mirror://sourceforge/preview-latex/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="emacs xemacs"

DEPEND="emacs? ( virtual/emacs
		>=app-emacs/auctex-11.14 )
	xemacs? ( virtual/xemacs
		>=app-xemacs/auctex-1.32 )
	>=app-text/ghostscript-7.05.6-r3
	virtual/tetex"

#RDEPEND=""

src_unpack() {
	unpack ${A}
	cp -a ${P}/* ${T}
}

src_compile() {
	if [ "`use emacs`" -a "`use xemacs`" ] ; then
		econf --with-emacs \
			--with-lispdir=${D}/usr/share/emacs/site-lisp/${PN} \
			|| die
		emake || die
		cd ${T}
		econf --with-xemacs \
			--with-packagedir=${D}/usr/lib/xemacs/site-packages \
			|| die
		emake || die
	elif [ "`use emacs`" -o "`use xemacs`" ] ; then
		local myconf
		if [ "`use emacs`" ] ; then
			myconf="--with-emacs
				--with-lispdir=${D}/usr/share/emacs/site-lisp/${PN}"
		elif [ "`use xemacs`" ] ; then
			myconf="--with-xemacs
				--with-packagedir=${D}/usr/lib/xemacs/site-packages"
		fi
		econf ${myconf} || die
		emake || die
	else
		econf || die
		emake || die
	fi
}

src_install() {
	# hack.- we cant call texhash within the make install because of sandbox violations
	# doing it later by hand
	if [ "`use emacs`" -a "`use xemacs`" ] ; then
		einstall texmfdir=${D}${TEXMF} TEXHASH=/bin/true || die
		pushd ${T}
		einstall texmfdir=${D}${TEXMF} TEXHASH=/bin/true || die
		popd
	else
		einstall texmfdir=${D}${TEXMF} TEXHASH=/bin/true || die
	fi

	if [ -n "`use emacs`" ] ; then
		elisp-site-file-install ${FILESDIR}/60preview-latex-gentoo.el
	fi

	dodoc ChangeLog FAQ INSTALL PROBLEMS README RELEASE TODO doc/preview-latex.dvi
}

pkg_postinst() {
	latex-package_pkg_postinst
	use emacs && elisp-site-regen
}

pkg_postrm() {
	latex-package_pkg_postrm
	use emacs && elisp-site-regen
}
