# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-4.1_rc3.ebuild,v 1.1 2004/10/14 14:40:48 usata Exp $

inherit elisp

IUSE="ssl"

DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/beta/${P/_/}.tar.gz"

LICENSE="BSD"
SLOT="0"
# 4.x is meant to be a development branch, so please don't unmask it!
KEYWORDS="~x86 ~alpha ~amd64 ~ppc-macos"

RDEPEND="ssl? ( =net-misc/stunnel-3* )"

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

	dodoc 00*

	insinto /etc/skel
	newins mew.dot.mew .mew.el
	newins mew.dot.emacs .emacs.mew
}
