# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ledger/ledger-2.5.ebuild,v 1.1 2006/11/18 10:53:51 wrobel Exp $

inherit eutils elisp

DESCRIPTION="Ledger is an command-line accounting tool that provides double-entry accounting with a minimum of frills, and yet with a maximum of expressiveness and flexibility."
HOMEPAGE="http://www.newartisans.com/software.html"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="NewArtisans"
KEYWORDS="~x86"
SLOT="0"
IUSE="emacs debug gnuplot ofx xml"

DEPEND="dev-libs/gmp
	dev-libs/libpcre
	ofx? ( >=dev-libs/libofx-0.7 )
	xml? ( dev-libs/expat )
	emacs? ( app-editors/emacs )
	gnuplot? ( sci-visualization/gnuplot )"

SITEFILE=50ledger-mode-gentoo.el

src_compile() {

	econf \
		$(use_enable xml) \
		$(use_enable ofx) \
		$(use_enable debug) \
		|| die "Configure failed!"

	emake || die "Make failed!"

	use emacs  && elisp_src_compile
}

src_install() {

	dodoc sample.dat README NEWS ledger.pdf

	## One script uses vi, the outher the Finance perl module
	## Did not add more use flags though
	insinto /usr/share/${P}
	doins scripts/entry scripts/getquote scripts/bal scripts/bal-huquq

	if use emacs; then
		elisp_src_install
	fi

	einstall || die "Installation failed!"

	if use gnuplot; then
		mv scripts/report ledger-report
		dobin ledger-report
	fi
}
