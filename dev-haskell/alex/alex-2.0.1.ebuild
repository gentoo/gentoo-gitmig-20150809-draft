# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/alex/alex-2.0.1.ebuild,v 1.1 2005/03/23 14:08:15 kosmikus Exp $
#
# USE variable summary:
#   doc	   - Build extra documenation from DocBook sources,
#		in HTML format.
#   tetex  - Build the above docs as PostScript as well.


inherit base eutils ghc-package
IUSE="doc tetex"

DESCRIPTION="A lexical analyser generator for Haskell"
SRC_URI="http://www.haskell.org/alex/dist/${P}-src.tar.gz"
HOMEPAGE="http://www.haskell.org/alex"

SLOT="0"
KEYWORDS="~x86"
LICENSE="as-is"

DEPEND=">=virtual/ghc-6.2.2
	doc? (	~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2
		java? ( >=dev-java/fop-0.20.5 ) )"

RDEPEND=""

src_compile() {
	local mydoc
	econf || die "econf failed"

	# determine what to do with documentation
	if use doc; then
		mydoc="html"
		if use java; then
			mydoc="${mydoc} ps"
		fi
	else
		mydoc=""
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk
	fi
	echo XMLDocWays="${mydoc}" >> mk/build.mk

	emake -j1 || die "make failed"
}

src_install() {
	local insttarget

	insttarget="install"
	use doc && insttarget="${insttarget} install-docs"
	emake -j1 ${insttarget} \
		prefix="${D}/usr" \
		datadir="${D}/usr/share/doc/${PF}" \
		infodir="${D}/usr/share/info" \
		mandir="${D}/usr/share/man" \
		libdir0="${D}/usr/$(get-libdir)" \
		|| die "make ${insttarget} failed"

	cd ${S}/haddock
	dodoc CHANGES LICENSE README TODO

	# if use doc; then
	#	cd ${S}/alex/doc
	#	dohtml -r alex/* || die
	#	dosym alex.html /usr/share/doc/${PF}/html/index.html
	#	if use tetex; then
	#		docinto ps
	#		dodoc alex.ps || die "dodoc failed"
	#	fi
	# fi
}
