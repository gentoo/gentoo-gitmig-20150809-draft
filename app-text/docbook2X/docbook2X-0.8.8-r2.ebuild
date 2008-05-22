# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook2X/docbook2X-0.8.8-r2.ebuild,v 1.1 2008/05/22 17:13:16 pva Exp $

inherit eutils

DESCRIPTION="Tools to convert docbook to man and info"
SRC_URI="mirror://sourceforge/docbook2x/${P}.tar.gz"
HOMEPAGE="http://docbook2x.sourceforge.net/"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="test"
LICENSE="MIT"

# dev-perl/XML-LibXML - although not mentioned upstream is required
# for make check to complete.
DEPEND="dev-lang/perl
	dev-libs/libxslt
	dev-perl/XML-NamespaceSupport
	dev-perl/XML-SAX
	dev-perl/XML-LibXML
	app-text/docbook-xsl-stylesheets
	=app-text/docbook-xml-dtd-4.2*"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patches from debian, for description see patches itself.
	epatch "${FILESDIR}"/${P}-filename_whitespace_handling.patch
	epatch "${FILESDIR}"/${P}-preprocessor_declaration_syntax.patch
	epatch "${FILESDIR}"/${P}-error_on_missing_refentry.patch
}

src_compile() {
	econf \
		--with-xslt-processor=libxslt \
		--program-transform-name='s,\(docbook2.*\),\1.pl,' \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}

pkg_postinst() {
	elog "To avoid conflict with docbook-sgml-utils, which is much more widely used,"
	elog "all executables have been renamed to *.pl."
}
