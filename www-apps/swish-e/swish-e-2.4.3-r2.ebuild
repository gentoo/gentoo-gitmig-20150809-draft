# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/swish-e/swish-e-2.4.3-r2.ebuild,v 1.4 2006/12/28 19:21:23 the_paya Exp $

inherit perl-module eutils

DESCRIPTION="Simple Web Indexing System for Humans - Enhanced"
HOMEPAGE="http://www.swish-e.org/"
SRC_URI="http://www.swish-e.org/distribution/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc perl pdf mp3"

DEPEND=">=sys-libs/zlib-1.1.3
	dev-libs/libxml2
	pdf?  ( app-text/poppler )
	perl? (	dev-perl/libwww-perl
			dev-perl/HTML-Parser
			dev-perl/HTML-Tagset
			dev-perl/MIME-Types
			dev-perl/HTML-Template
			dev-perl/HTML-FillInForm
			dev-perl/Template-Toolkit
			mp3? ( dev-perl/MP3-Tag )
	)"


src_unpack() {
	if has_version 'www-apps/swish-e'; then
		ewarn "Your old swish-e indexes may not be compatible with this version."
		epause 10
	fi
	unpack ${A}
}
src_compile() {
	econf || die "configuration failed"
	# XXX: is this -j1 really needed ?
	emake -j1 || die "emake failed"
}

src_install() {
	dobin src/swish-e || die "dobin failed"
	dodoc INSTALL README
	make DESTDIR="${D}" install || die

	if use doc; then
		dodir /usr/share/doc/${PF}
		cp -r html conf "${D}"/usr/share/doc/${PF} || die "cp failed"
	fi

	if use perl ; then
		epatch ${FILESDIR}/perl-makefile.patch
		cd ${S}/perl
		myconf="SWISHBINDIR=${D}/usr/bin SWISHIGNOREVER SWISHSKIPTEST"
		perl-module_src_compile
		cd ${S}/perl
		perl-module_src_install
	fi
}

pkg_postinst() {
	einfo "If you wish to be able to index MS Word documents, "
	einfo "emerge app-text/catdoc"
	einfo
	einfo "If you wish to be able to index MS Excel Spreadsheets,"
	einfo "emerge dev-perl/SpreadSheet-ParseExcel and"
	einfo "dev-perl/HTML-Parser"
}
