# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-html-template/cl-html-template-0.1.2.ebuild,v 1.2 2003/09/06 22:35:54 msterret Exp $

inherit common-lisp

DESCRIPTION="HTML-TEMPLATE is a portable library for Common Lisp which can be used to fill templates with arbitrary (string) values at runtime. (Actually, it doesn't matter whether the result is HTML. It's just very likely that this will be what the library is mostly used for.)  It is loosely modeled after the Perl module HTML::Template and compatible with a subset of its syntax, i.e. it should be possible to use your HTML-TEMPLATE templates with HTML::Template as well (but usually not the other way around)."
HOMEPAGE="http://weitz.de/html-template/
	http://www.cliki.net/html-template"
SRC_URI="mirror://gentoo/${P/cl-/}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=html-template

S=${WORKDIR}/${P/cl-/}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc CHANGELOG INSTALLATION
	dohtml doc/*.html
}
