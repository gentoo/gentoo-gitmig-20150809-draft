# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/html2latex/html2latex-1.1.ebuild,v 1.2 2005/08/20 07:45:17 hansmi Exp $

inherit perl-module

DESCRIPTION="Perl script to convert HTML files into formatted LaTeX"
HOMEPAGE="http://html2latex.sourceforge.net/"
SRC_URI="mirror://sourceforge/html2latex/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE="imagemagick libwww"

DEPEND="dev-perl/HTML-Tree
	dev-perl/XML-Simple
	imagemagick? ( media-gfx/imagemagick )
	libwww? ( dev-perl/libwww-perl )"

src_compile() {
	# HTML::LaTex
	cd HTML
	perl-module_src_prep
	perl-module_src_compile
}


src_install() {
	dobin html2latex
	doman html2latex.1
	dodoc README TODO

	# HTML::LaTex
	cd HTML
	perl-module_src_install
}
