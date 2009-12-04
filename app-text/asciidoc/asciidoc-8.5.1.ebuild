# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/asciidoc/asciidoc-8.5.1.ebuild,v 1.1 2009/12/04 16:55:12 flameeyes Exp $

EAPI="2"

DESCRIPTION="A text document format for writing short documents, articles, books and UNIX man pages"
HOMEPAGE="http://www.methods.co.nz/asciidoc/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples vim-syntax"

RDEPEND=">=virtual/python-2.4
		>=app-text/docbook-xsl-stylesheets-1.75
		dev-libs/libxslt
		media-gfx/graphviz
		app-text/docbook-xml-dtd:4.5
		|| ( www-client/lynx www-client/w3m )"
DEPEND=""

src_prepare() {
	if ! use vim-syntax; then
		sed -i -e '/^install/s/install-vim//' Makefile.in
	else
		sed -i\
			-e '/^vimdir/s/@sysconfdir@\/vim/\/usr\/share\/vim\/vimfiles/' \
			-e 's/\/etc\/vim//' \
			Makefile.in || die
	fi
}

src_configure() {
	econf --sysconfdir=/usr/share || die
}

src_install() {
	dodir /usr/bin

	use vim-syntax && dodir /usr/share/vim/vimfiles

	emake DESTDIR="${D}" install || die "install failed"

	if use examples; then
		# This is a symlink to a directory
		rm examples/website/images || die

		insinto /usr/share/doc/${PF}
		doins -r examples || die
		dosym /usr/share/asciidoc/images /usr/share/doc/${PF}/examples || die
	fi

	dohtml doc/*.html || die
	dosym /usr/share/asciidoc/images /usr/share/doc/${PF}/html || die
	dosym /usr/share/asciidoc/stylesheets/docbook-xsl.css /usr/share/doc/${PF}/html || die

	dodoc BUGS CHANGELOG README docbook-xsl/asciidoc-docbook-xsl.txt || die
}
