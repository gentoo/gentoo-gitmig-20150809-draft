# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/alex/alex-2.0.1-r1.ebuild,v 1.10 2006/08/24 20:33:14 fmccor Exp $
#
# USE variable summary:
#   doc	   - Build extra documenation from DocBook sources,
#		in HTML format.
#   java   - Build the above docs as PostScript as well.


inherit base eutils ghc-package
IUSE="doc"
# java use flag disabled because of bug #107019

DESCRIPTION="A lexical analyser generator for Haskell"
SRC_URI="http://www.haskell.org/alex/dist/${P}-src.tar.gz"
HOMEPAGE="http://www.haskell.org/alex"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ppc64 sparc x86"
LICENSE="as-is"

DEPEND=">=virtual/ghc-6.2
	doc? (	~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2 )"
# java? >=dev-java/fop-0.20.5
RDEPEND=""

src_compile() {
	einfo "$(get_libdir)"
	local mydoc
	econf || die "econf failed"

	# determine what to do with documentation
	if use doc; then
		mydoc="html"
		#if use java; then
		#	mydoc="${mydoc} ps"
		#fi
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
		libdir0="${D}/usr/$(get_libdir)" \
		|| die "make ${insttarget} failed"

	cd ${S}/haddock
	dodoc README
}
