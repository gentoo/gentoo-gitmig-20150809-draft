# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tramp/tramp-2.0.56.ebuild,v 1.1 2007/08/18 16:37:25 ulm Exp $

inherit elisp eutils

DESCRIPTION="Edit remote files like ange-ftp but with rlogin, telnet and/or ssh"
HOMEPAGE="http://savannah.gnu.org/projects/tramp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~ppc"
IUSE=""

SITEFILE=51${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	# the 2.0.56 tarball contains a truncated "configure" file
	epatch "${FILESDIR}/${P}-configure.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	elisp-make-autoload-file lisp/${PN}-autoloads.el lisp \
		|| die "elisp-make-autoload-file failed"
}

src_install() {
	dodir /usr/share/info
	dodir /usr/share/emacs/etc
	dodir /usr/share/emacs/site-lisp/tramp

	einstall lispdir="${D}/usr/share/emacs/site-lisp/tramp" || die

	mv "${D}/usr/share/info/tramp" "${D}/usr/share/info/tramp-info"

	dohtml texi/*.html
	if [ -f texi/tramp.dvi ]; then
		insinto /usr/share/doc/${PF}
		doins texi/tramp.dvi
	fi

	elisp-install ${PN} lisp/${PN}-autoloads.el
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc README ChangeLog CONTRIBUTORS || die "dodoc failed"
}
