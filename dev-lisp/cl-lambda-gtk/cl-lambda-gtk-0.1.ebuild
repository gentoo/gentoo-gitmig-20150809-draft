# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-lambda-gtk/cl-lambda-gtk-0.1.ebuild,v 1.2 2005/04/16 20:38:11 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Lambda-GTK is a cross-platform Common Lisp interface to GTK+2."
HOMEPAGE="http://common-lisp.net/project/lambda-gtk/"
SRC_URI="ftp://common-lisp.net/pub/project/lambda-gtk/lambda-gtk-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=lambda-gtk

S=${WORKDIR}/lambda-gtk-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/lambda-gtk/lambda-gtk.asd \
		/usr/share/common-lisp/systems/lambda-gtk-examples.asd
	dohtml lambda-gtk.html
	dodoc llgpl.text ${FILESDIR}/README.Gentoo
}
