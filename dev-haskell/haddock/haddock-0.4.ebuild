# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haddock/haddock-0.4.ebuild,v 1.1 2003/05/22 06:49:31 kosmikus Exp $
#
# USE variable summary:
#   doc    - Build extra documenation from DocBook sources,
#               in HTML format.
#   tetex  - Build the above docs as PostScript as well.


IUSE="doc tetex"

DESCRIPTION="A documentation tool for Haskell"
SRC_URI="http://www.haskell.org/haddock/${P}-src.tar.gz"
HOMEPAGE="http://www.haskell.org/haddock"

SLOT="0"
KEYWORDS="~x86 ~sparc"
LICENSE="as-is"

DEPEND="dev-lang/ghc
	doc? ( >=app-text/openjade-1.3.1 
		>=app-text/sgml-common-0.6.3
		=app-text/docbook-sgml-dtd-3.1-r1
		>=app-text/docbook-dsssl-stylesheets-1.64
		tetex? ( >=app-text/tetex-1.0.7
 			>=app-text/jadetex-3.12 ) )"

RDEPEND=""

src_compile() {
	# unset SGML_CATALOG_FILES because documentation installation
	# breaks otherwise ...
	SGML_CATALOG_FILES="" econf
	# using make because emake behaved strangely on my machine
	make || die

        # if documentation has been requested, build documentation ...
	if use doc; then
		cd ${S}/haddock/doc
		emake html || die
		if use tetex; then
			emake ps || die
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
		mandir="${D}/usr/share/man" || die

	cd ${S}/haddock
	dodoc CHANGES LICENSE README TODO

	if [ "`use doc`" ]; then
		cd ${S}/haddock/doc
		dohtml -r haddock/* || die
		dosym haddock.html /usr/share/doc/${PF}/html/index.html
		if [ "`use tetex`" ]; then
			docinto ps
			dodoc haddock.ps || die
		fi
	fi
}
