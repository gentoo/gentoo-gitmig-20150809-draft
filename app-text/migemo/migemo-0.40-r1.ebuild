# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/migemo/migemo-0.40-r1.ebuild,v 1.10 2004/07/19 13:24:32 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="Migemo is Japanese Incremental Search Tool"
HOMEPAGE="http://migemo.namazu.org/"
SRC_URI="http://migemo.namazu.org/stable/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 alpha sparc ppc hppa macos"
SLOT="0"

DEPEND="app-emacs/apel
	virtual/ruby
	dev-ruby/ruby-romkan
	dev-ruby/ruby-bsearch
	app-dicts/migemo-dict"

src_unpack() {

	unpack ${A}

	cp /usr/share/migemo/migemo-dict ${S}

}

src_compile() {

	econf || die
	# emake b0rks
	emake -j1 || die

}

src_install() {

	make DESTDIR=${D} install || die

	rm ${D}/usr/share/migemo/migemo-dict

	elisp-site-file-install ${FILESDIR}/50migemo-gentoo.el
	dodoc AUTHORS ChangeLog INSTALL README

}
