# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/alex/alex-2.0.ebuild,v 1.10 2005/03/23 14:08:15 kosmikus Exp $
#
# USE variable summary:
#   doc    - Build extra documenation from DocBook sources,
#               in HTML format.
#   tetex  - Build the above docs as PostScript as well.


inherit base
IUSE="doc tetex"

DESCRIPTION="A lexical analyser generator for Haskell"
SRC_URI="http://www.haskell.org/alex/dist/${P}-src.tar.bz2"
HOMEPAGE="http://www.haskell.org/alex"

SLOT="0"
KEYWORDS="~x86"
LICENSE="as-is"

DEPEND=">=virtual/ghc-5.04
	!>=virtual/ghc-6.4
	doc? ( >=app-text/openjade-1.3.1
		>=app-text/sgml-common-0.6.3
		~app-text/docbook-sgml-dtd-3.1
		>=app-text/docbook-dsssl-stylesheets-1.64
		tetex? ( virtual/tetex
			>=app-text/jadetex-3.12 ) )"

RDEPEND=""

# extend path to /opt/ghc/bin to guarantee that ghc-bin is found
GHCPATH="${PATH}:/opt/ghc/bin"

src_compile() {
	# fix string gaps
	sed -i -e 's/\\ $/" ++/' -e 's/^\([ \t]*\)\\/\1"/' alex/src/Main.hs
	# fix version string
	sed -i -e 's/ALEX_VERSION/'"${PV}"'/' -e 's/tail ""/tail $ ""/' alex/src/Main.hs

	# unset SGML_CATALOG_FILES because documentation installation
	# breaks otherwise ...
	PATH="${GHCPATH}" SGML_CATALOG_FILES="" econf || die "econf failed"
	emake -j1 || die "make failed"

	# if documentation has been requested, build documentation ...
	if use doc; then
		cd ${S}/haddock/doc
		emake html || die "make html failed"
		if use tetex; then
			emake ps || die "make ps failed"
		fi
	fi
}

src_install() {
	local mydoc

	use doc && mydoc="html" || mydoc=""
	use doc && use tetex && mydoc="${mydoc} ps"

	echo SGMLDocWays="${mydoc}" >> mk/build.mk
	make install install-docs \
		prefix="${D}/usr" \
		datadir="${D}/usr/share/doc/${PF}" \
		infodir="${D}/usr/share/info" \
		mandir="${D}/usr/share/man" || die "make install failed"

	cd ${S}/haddock
	dodoc CHANGES LICENSE README TODO

	if use doc; then
		cd ${S}/alex/doc
		dohtml -r alex/* || die
		dosym alex.html /usr/share/doc/${PF}/html/index.html
		if use tetex; then
			docinto ps
			dodoc alex.ps || die "dodoc failed"
		fi
	fi
}
