# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/migemo/migemo-0.40-r1.ebuild,v 1.18 2007/02/03 23:35:45 flameeyes Exp $

inherit elisp

DESCRIPTION="Migemo is Japanese Incremental Search Tool"
HOMEPAGE="http://0xcc.net/migemo/"
SRC_URI="http://0xcc.net/migemo/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 ppc-macos sparc x86"
IUSE=""

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
