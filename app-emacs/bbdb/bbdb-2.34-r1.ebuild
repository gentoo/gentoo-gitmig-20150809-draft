# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/bbdb/bbdb-2.34-r1.ebuild,v 1.3 2004/03/04 04:59:39 jhuebel Exp $

inherit elisp

IUSE="crypt"

DESCRIPTION="The Big Brother Database"
HOMEPAGE="http://bbdb.sourceforge.net/"
SRC_URI="http://bbdb.sourceforge.net/${P}.tar.gz
	http://www.mit.edu/afs/athena/contrib/emacs-contrib/Fin/point-at.el
	http://www.mit.edu/afs/athena/contrib/emacs-contrib/Fin/dates.el"
LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/emacs
crypt? app-emacs/mailcrypt"

S="${WORKDIR}/${P}"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}/bits
	mv bbdb-mail-folders.el bbdb-mail-folders.txt
	sed -e "0,/^--- bbdb-mail-folders.el ---$/d" \
		-e "/^--- end ---$/,+4d" \
		bbdb-mail-folders.txt > bbdb-mail-folders.el
	mv bbdb-sort-mailrc.el bbdb-sort-mailrc.txt
	sed -e "0,/^Bng$/d" \
		bbdb-sort-mailrc.txt > bbdb-sort-mailrc.el
	cp ${DISTDIR}/{dates,point-at}.el .

	if ! use crypt; then
		rm ${S}/bits/bbdb-pgp.el
		einfo "Excluding bits/bbdb-pgp.el because the \`crypt' USE flag was not"
		einfo "specified."
	fi

}

src_compile() {

	econf --with-emacs=emacs || die "econf failed"
	make || die
	echo "(add-to-list 'load-path \"${S}/bits\")" > ${T}/lp.el
	emacs -batch -q --no-site-file --no-init-file \
		-l ${T}/lp.el -f batch-byte-compile bits/*.el || die
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc || die
	elisp-install ${PN}/bits bits/*.el bits/*.elc || die
	elisp-site-file-install ${FILESDIR}/50bbdb-gentoo.el || die

	doinfo texinfo/*.info*
	dodoc ChangeLog INSTALL README bits/*.txt
	newdoc bits/README README.bits
}
