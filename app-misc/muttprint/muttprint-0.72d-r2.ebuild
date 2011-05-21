# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.72d-r2.ebuild,v 1.1 2011/05/21 19:40:12 hwoarang Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="Script for pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net/"
SRC_URI="mirror://sourceforge/muttprint/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="virtual/latex-base
	dev-texlive/texlive-latexextra
	dev-lang/perl
	dev-perl/TimeDate
	dev-perl/Text-Iconv
	dev-perl/File-Which
	app-text/psutils"

src_prepare() {
	epatch "${FILESDIR}/${PN}-rem_sig.patch"
	epatch "${FILESDIR}/${PN}-ldflags.patch"
	epatch "${FILESDIR}/${PN}-no_html_docs.patch"
	epatch "${FILESDIR}/${PN}-CVE-2008-5368.patch"
	epatch "${FILESDIR}/${P}-warning.patch"
}

src_compile() {
	tc-export CC
	default
}

src_install() {
	make prefix="${D}"/usr docdir="${D}"/usr/share/doc docdirname=${PF} install || die
}
