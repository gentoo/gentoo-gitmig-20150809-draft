# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-4.1.ebuild,v 1.8 2005/03/30 16:20:56 hansmi Exp $

inherit elisp

IUSE="ssl"

DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/release/${P/_/}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 alpha amd64 ~ppc ~ppc-macos sparc"

RDEPEND="ssl? ( net-misc/stunnel )"

SITEFILE=50mew-gentoo.el

S=${WORKDIR}/${P/_/}

src_compile() {
	emake || die
}

src_install() {
	einstall prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN} \
		mandir=${D}/usr/share/man/man1 || die

	elisp-site-file-install ${FILESDIR}/3.x/${SITEFILE}

	dodoc 00* mew.dot.*
}

pkg_postinst() {
	elisp-site-regen
	einfo
	einfo "Please refer to /usr/share/doc/${PF} for sample configuration files."
	einfo
}

pkg_postrm() {
	elisp-site-regen
}
