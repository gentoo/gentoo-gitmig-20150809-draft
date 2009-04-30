# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/grisbi/grisbi-0.5.8.ebuild,v 1.7 2009/04/30 17:57:02 aballier Exp $

inherit eutils

IUSE="print nls ofx"

DESCRIPTION="Grisbi is a personal accounting application for Linux"
HOMEPAGE="http://www.grisbi.org"
SRC_URI="mirror://sourceforge/grisbi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2.2.0
	ofx? ( >=dev-libs/libofx-0.7.0 )
	print? (
		virtual/latex-base
		|| ( >=dev-texlive/texlive-latexextra-2008 >=dev-tex/latex-unicode-20041017 )
		)"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

pkg_setup() {
	if ! use print; then
		elog
		elog "NOTE: The USE variable 'print' is not in your USE flags."
		elog "For printing support in grisbi, you will need to restart"
		elog "the build with USE=\"print\""
		elog
		ebeep 5
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply location patchs
	ebegin "Applying Gentoo documentation location patch"
	for i in \
		$(find ./ -name 'Makefile.*') \
		$(find ./ -name 'grisbi-manuel/html')
			do
				sed -i "s;doc/grisbi/help;doc/${PF}/help;g" "${i}"
			done
	eend 0

	epatch "${FILESDIR}/${PN}-0.5.6-latex-unicode.patch"
}

src_compile() {

	econf \
		$(use_with ofx) \
		$(use_enable nls) || die

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
	insinto /usr/share/applications
	doins "${FILESDIR}"/grisbi.desktop
}

pkg_postinst() {
	pkg_setup

	elog "The first thing you should do is set up the browser command in"
	elog "preferences after you start up grisbi.  Otherwise you will not"
	elog "be able to see the help and manuals"
}
