# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-3.2.ebuild,v 1.3 2003/05/29 11:39:27 yakina Exp $

inherit elisp

IUSE=""

DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/release/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
S="${WORKDIR}/${P}"

DEPEND="virtual/emacs"

SITEFILE=50mew-gentoo.el

src_compile() {
	emake || die
}

src_install() {
	einstall prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN} || die

	elisp-site-file-install ${FILESDIR}/${PV}/${SITEFILE} || die

	dodoc 00*

	insinto /etc/skel
	newins mew.dot.mew .mew.el
	newins mew.dot.emacs .emacs.mew

	einfo "Refer to the Info documentation on Mew for how to get started."
	einfo ""
	einfo "If you use mew-2.* until now, you should rewrite \${HOME}/.mew.el"
	einfo ""
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}

