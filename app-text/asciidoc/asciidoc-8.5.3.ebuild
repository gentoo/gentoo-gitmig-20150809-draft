# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/asciidoc/asciidoc-8.5.3.ebuild,v 1.4 2010/08/14 00:41:12 phajdan.jr Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="3.*"

inherit python

DESCRIPTION="A text document format for writing short documents, articles, books and UNIX man pages"
HOMEPAGE="http://www.methods.co.nz/asciidoc/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="examples vim-syntax"

RDEPEND=">=app-text/docbook-xsl-stylesheets-1.75
		dev-libs/libxslt
		media-gfx/graphviz
		app-text/docbook-xml-dtd:4.5
"
DEPEND=""

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	if ! use vim-syntax; then
		sed -i -e '/^install/s/install-vim//' Makefile.in
	else
		sed -i\
			-e "/^vimdir/s:@sysconfdir@/vim:${EPREFIX}/usr/share/vim/vimfiles:" \
			-e 's:/etc/vim::' \
			Makefile.in || die
	fi

	# Only needed for prefix - harmless (does nothing) otherwise
	sed -i -e "s:^CONF_DIR=.*:CONF_DIR='${EPREFIX}/etc/asciidoc':" \
		"${S}/asciidoc.py" || die
}

src_configure() {
	econf --sysconfdir="${EPREFIX}"/usr/share
}

src_install() {
	use vim-syntax && dodir /usr/share/vim/vimfiles

	emake DESTDIR="${D}" install || die "install failed"

	python_convert_shebangs -r 2 "${D}"

	if use examples; then
		# This is a symlink to a directory
		rm examples/website/images || die

		insinto /usr/share/doc/${PF}
		doins -r examples || die
		dosym ../../../asciidoc/images /usr/share/doc/${PF}/examples || die
	fi

	dohtml doc/*.html || die
	dosym ../../../asciidoc/images /usr/share/doc/${PF}/html || die
	dosym ../../../asciidoc/stylesheets/docbook-xsl.css /usr/share/doc/${PF}/html || die

	dodoc BUGS CHANGELOG README docbook-xsl/asciidoc-docbook-xsl.txt || die
}
