# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-typesetting/cl-typesetting-110.ebuild,v 1.2 2006/04/14 10:03:27 swegener Exp $

inherit common-lisp eutils

DESCRIPTION="CL-TYPESETTING is a complete typesetting system written in Common Lisp."
HOMEPAGE="http://www.fractalconcept.com/asp/BCg/sdataQ0709qxv9wpLDM==/asdataQucgleWmCuSG9eWI$Nmw"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~amd64 ~x86"
IUSE=""

DEPEND="dev-lisp/cl-pdf"

CLPACKAGE="cl-typesetting cl-typegraph"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	dodir $CLSYSTEMROOT
	insinto $CLSOURCEROOT/cl-typesetting
	doins *.{lisp,asd}
	dosym $CLSOURCEROOT/cl-typesetting/cl-typesetting.asd $CLSYSTEMROOT/cl-typesetting.asd
	dosym $CLSOURCEROOT/cl-typesetting/cl-typegraph.asd $CLSYSTEMROOT/cl-typegraph.asd
	insinto /usr/share/cl-typesetting/hyphen-patterns
	doins hyphen-patterns/*
	insinto /usr/share/doc/${PF}/contrib/xhtml-renderer
	doins contrib/xhtml-renderer/*
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	insinto /usr/share/doc/${PF}/files-for-example
	doins files-for-example/*
	dodoc *.txt
}
