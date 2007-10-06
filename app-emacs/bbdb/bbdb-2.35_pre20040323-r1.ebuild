# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/bbdb/bbdb-2.35_pre20040323-r1.ebuild,v 1.3 2007/10/06 15:52:04 ulm Exp $

inherit elisp eutils

DESCRIPTION="The Big Brother Database"
HOMEPAGE="http://bbdb.sourceforge.net/"
# taken from http://bbdb.sourceforge.net/${P}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://www.mit.edu/afs/athena/contrib/emacs-contrib/Fin/point-at.el
	http://www.mit.edu/afs/athena/contrib/emacs-contrib/Fin/dates.el"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="crypt tetex"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	crypt? ( app-emacs/mailcrypt )
	tetex? ( virtual/tetex )"

SITEFILE=50${PN}-gentoo.el

S="${WORKDIR}/${P/_pre*/}"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/bbdb-decode-header.diff
	cd "${S}"/bits
	mv bbdb-mail-folders.el bbdb-mail-folders.txt
	sed -e "0,/^--- bbdb-mail-folders.el ---$/d" \
		-e "/^--- end ---$/,+4d" \
		bbdb-mail-folders.txt > bbdb-mail-folders.el
	mv bbdb-sort-mailrc.el bbdb-sort-mailrc.txt
	sed -e "0,/^Bng$/d" \
		bbdb-sort-mailrc.txt > bbdb-sort-mailrc.el
	cp ${DISTDIR}/{dates,point-at}.el .

	if ! use crypt ; then
		rm "${S}"/bits/bbdb-pgp.el
		elog "Excluding bits/bbdb-pgp.el because the \`crypt' USE flag was not"
		elog "specified."
	fi
}

src_compile() {
	econf --with-emacs=emacs || die "econf failed"
	emake -j1 || die "emake failed"
	cat >"${T}"/lp.el<<-EOF
		(add-to-list 'load-path "${S}/bits")
		(add-to-list 'load-path "${S}/lisp")
	EOF
	emacs -batch -q --no-site-file --no-init-file \
		-l "${T}"/lp.el -f batch-byte-compile bits/*.el \
		|| die "make bits failed"
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc || die
	elisp-install ${PN}/bits bits/*.el bits/*.elc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo texinfo/*.info*
	dodoc ChangeLog INSTALL README bits/*.txt
	newdoc bits/README README.bits
	if use tetex; then
		insinto /usr/share/texmf/tex/bbdb
		doins tex/*.tex
	fi
}

pkg_postinst() {
	elisp-site-regen
	use tetex && texconfig rehash
}

pkg_postrm() {
	elisp-site-regen
	use tetex && texconfig rehash
}
