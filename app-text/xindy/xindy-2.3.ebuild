# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xindy/xindy-2.3.ebuild,v 1.2 2008/05/19 23:26:37 aballier Exp $

DESCRIPTION="A Flexible Indexing System"

HOMEPAGE="http://www.xindy.org/"
SRC_URI="mirror://sourceforge/xindy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc"
RDEPEND="virtual/latex-base
	>=dev-lisp/clisp-2.44.1-r1
	|| ( dev-texlive/texlive-langcyrillic app-text/tetex app-text/ptex )"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {
	local clisp_dir
	clisp_dir=`clisp  --version | grep "Installation directory:" | sed 's/Installation directory: //'`
	econf \
	    $(use_enable doc docs) \
		--enable-external-clisp --enable-clisp-dir=${clisp_dir}
	VARTEXFONTS="${T}/fonts" emake -j1 || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog.Gour NEWS README
}
