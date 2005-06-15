# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ucw/cl-ucw-0.3.9.ebuild,v 1.5 2005/06/15 20:31:53 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="UnCommon Web is a continuation based, component oriented dynamic web application framework written in Common Lisp."
HOMEPAGE="http://common-lisp.net/project/ucw/index.html"
SRC_URI="ftp://ftp.common-lisp.net/pub/project/ucw/ucw_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="mod_lisp araneida aserve doc"

DEPEND=">=dev-lisp/cl-iterate-1.4
	>=dev-lisp/cl-rfc2388-0.9
	>=dev-lisp/cl-arnesi-1.4.0_p5
	>=dev-lisp/cl-yaclml-0.5_p26
	dev-lisp/cl-icu
	mod_lisp? ( || ( www-apache/mod_lisp www-apache/mod_lisp2 ) )
	araneida? ( dev-lisp/cl-araneida )
	!araneida? ( dev-lisp/cl-puri )
	aserve? ( dev-lisp/cl-aserve )
	|| ( app-emacs/slime app-emacs/slime-cvs )
	doc? ( virtual/tetex )"

CLPACKAGE=ucw

S=${WORKDIR}/ucw_${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
	find ${S}/ -type d -name .arch-ids -exec rm -rf '{}' \; &>/dev/null
}

src_compile() {
	if use doc; then
		einfo "Won't build documentation for the time being."
#		make -C docs
	fi
}

src_install() {
	dodir /usr/share/common-lisp/source/ucw
	dodir /usr/share/common-lisp/systems
	insinto /usr/share/common-lisp/source/ucw/
	doins -r src examples
	common-lisp-install ucw.asd
	common-lisp-system-symlink
	dodoc README CHANGES
	dohtml -r docs/html/*
	insinto /usr/share/doc/${PF}/
	doins bin/*
	insinto /var/lib/ucw
	doins -r wwwroot
	dodoc ${FILESDIR}/README.Gentoo
	keepdir /var/log/ucw
}

pkg_postinst() {
	while read line; do einfo "${line}"; done <${FILESDIR}/README.Gentoo
}
