# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-acclaim/cl-acclaim-0.25.ebuild,v 1.2 2005/03/18 07:23:21 mkennedy Exp $

inherit common-lisp eutils

MY_PV=20040619-01

DESCRIPTION="Acclaim is a presentation program writen in Common Lisp"
HOMEPAGE="http://androgyn.bl0rg.net/~mgr/acclaim.html"
SRC_URI="http://androgyn.bl0rg.net/~mgr/resources/acclaim/acclaim-all-you-need_${MY_PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lisp/cl-clx"

CLPACKAGE=acclaim

S=${WORKDIR}/code

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-slides-pathname-gentoo.patch || die
	epatch ${FILESDIR}/${PV}-cmucl-eval-when-gentoo.patch || die
	epatch ${FILESDIR}/${PV}-load-slides-hint-gentoo.patch || die
	( cd ${S}; cat acclaim.asd ppm.asd >acclaim.asd.new && mv acclaim.asd.new acclaim.asd ) || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	insinto /usr/share/doc/${PF}/
	doins ${FILESDIR}/example.slides
}

pkg_postinst(){
	common-lisp_pkg_postinst
	while read line; do einfo "${line}"; done <<EOF

The Acclaim software wants to initally load a slide definition and
will tell you so.  There are several sample slides on Max-Gerd's site
to get you started: http://androgyn.bl0rg.net/~mgr/acclaim.html

Alternatively you can use the example slides installed as
/usr/share/doc/${PF}/example.slides

EOF
}
