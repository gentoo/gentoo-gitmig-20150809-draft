# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tramp/tramp-2.1.9.ebuild,v 1.1 2007/04/10 20:36:45 opfer Exp $

inherit elisp eutils

DESCRIPTION="edit remote files like ange-ftp but with rlogin, telnet and/or ssh"
HOMEPAGE="http://savannah.gnu.org/projects/tramp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
SITEFILE=50tramp-gentoo.el

# this is needed; elisp.eclass redefines src_compile() from portage default
src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/info
	dodir /usr/share/emacs/etc
	dodir /usr/share/emacs/site-lisp/tramp

	einstall lispdir="${D}/usr/share/emacs/site-lisp/tramp" || die

	mv "${D}/usr/share/info/tramp" "${D}/usr/share/info/tramp-info"

	dohtml texi/*.html
	if [ -f texi/tramp.dvi ] ; then
		insinto /usr/share/doc/${PF}
		doins texi/tramp.dvi
	fi

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc README ChangeLog CONTRIBUTORS
}
