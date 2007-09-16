# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ledger/ledger-2.5-r1.ebuild,v 1.4 2007/09/16 10:48:11 opfer Exp $

inherit eutils elisp-common

DESCRIPTION="Ledger is an command-line accounting tool that provides double-entry accounting with a minimum of frills, and yet with a maximum of expressiveness and flexibility."
HOMEPAGE="http://www.newartisans.com/software.html"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="NewArtisans"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="emacs debug gnuplot ofx xml"

DEPEND="dev-libs/gmp
	dev-libs/libpcre
	ofx? ( >=dev-libs/libofx-0.7 )
	xml? ( dev-libs/expat )
	emacs? ( virtual/emacs )
	gnuplot? ( sci-visualization/gnuplot )"

SITEFILE=50ledger-mode-gentoo.el

src_compile() {

	econf \
		$(use_enable xml) \
		$(use_enable ofx) \
		$(use_enable debug) \
		$(use_with	 emacs lispdir ${D}/usr/share/emacs/site-lisp/${PN}) \
		|| die "Configure failed!"

	emake || die "Make failed!"
}

src_install() {

	dodoc sample.dat README NEWS ledger.pdf

	## One script uses vi, the outher the Finance perl module
	## Did not add more use flags though
	insinto /usr/share/${P}
	doins scripts/entry scripts/getquote scripts/bal scripts/bal-huquq

	use emacs && elisp-site-file-install ${FILESDIR}/${SITEFILE}

	einstall || die "Installation failed!"

	if use gnuplot; then
		mv scripts/report ledger-report
		dobin ledger-report
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

