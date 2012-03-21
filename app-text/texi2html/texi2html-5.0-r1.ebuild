# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/texi2html/texi2html-5.0-r1.ebuild,v 1.2 2012/03/21 20:40:04 jer Exp $

EAPI=4

DESCRIPTION="Perl script that converts Texinfo to HTML"
HOMEPAGE="http://www.nongnu.org/texi2html/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.bz2"

LICENSE="CCPL-ShareAlike-1.0 FDL-1.3 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="unicode"

RDEPEND=">=dev-lang/perl-5.10.1
	dev-perl/libintl-perl
	unicode? (
		dev-perl/Text-Unidecode
		dev-perl/Unicode-EastAsianWidth
		)"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_configure() {
	local myconf
	use unicode && myconf='--with-external-Unicode-EastAsianWidth'

	econf \
		--with-external-libintl-perl \
		$(use_with unicode unidecode) \
		${myconf}
}

src_install() {
	default
	rm -f "${ED}"/usr/share/${PN}/images/{COPYING*,GPL,README}
}

pkg_preinst() {
	rm -f "${EROOT}"/usr/bin/${PN}
}
