# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-2.3-r1.ebuild,v 1.5 2004/04/04 16:19:06 usata Exp $

inherit elisp eutils

IUSE="cjk"

DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc"

S="${WORKDIR}/${P}"

DEPEND="virtual/emacs"

SITEFILE=50mew-gentoo.el

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/mew-smtp-${PV}-gentoo.patch
}

src_compile() {

	make || die
}

src_install() {

	einstall elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN} \
		mandir=${D}/usr/share/man/man1 || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	if [ -n "`use cjk`" ] ; then
		doinfo info/mew.jis*
	fi
	dodoc 00*
}

pkg_postinst() {

	elisp-site-regen

	einfo
	einfo "Refer to the Info documentation on Mew for how to get started."
	einfo
}

pkg_postrm() {

	elisp-site-regen
}
