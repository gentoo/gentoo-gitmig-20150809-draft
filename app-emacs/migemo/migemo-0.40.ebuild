# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/migemo/migemo-0.40.ebuild,v 1.2 2003/08/15 11:35:32 usata Exp $

inherit elisp

DESCRIPTION="Migemo is Japanese Incremental Search Tool"
HOMEPAGE="http://migemo.namazu.org/"
SRC_URI="http://migemo.namazu.org/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc ~sparc"
IUSE=""

DEPEND="${DEPEND}
	app-emacs/apel
	>=dev-lang/ruby-1.6
	dev-ruby/ruby-romkan
	dev-ruby/ruby-bsearch"

S=${WORKDIR}/${P}

SITEFILE=50migemo-gentoo.el

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc AUTHORS ChangeLog INSTALL README
}
