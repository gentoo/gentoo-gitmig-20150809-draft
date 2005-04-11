# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/grisbi/grisbi-0.5.4-r1.ebuild,v 1.3 2005/04/11 20:15:01 seemant Exp $
inherit eutils

IUSE="print nls ofx"

DESCRIPTION="Grisbi is a personal accounting application for Linux"
HOMEPAGE="http://www.grisbi.org"
SRC_URI="mirror://sourceforge/grisbi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2
	ofx? ( >=dev-libs/libofx-0.7.0 )"

RDEPEND="${DEPEND}
	print? ( virtual/tetex
	dev-tex/latex-unicode )"

pkg_setup() {
	if ! use print; then
		echo
		einfo
		einfo "NOTE: The USE variable 'print' is not in your USE flags."
		einfo "For printing support in grisbi, you will need to restart"
		einfo "the build with USE=\"print\""
		einfo
		echo
		ebeep 5
	fi
}

src_unpack() {

	unpack ${A}

	# Apply location patchs
	ebegin "Applying Gentoo documentation location patch"
		cd ${S}
		for i in \
			`find ./ -name 'Makefile.*'` \
			`find ./ -name 'grisbi-manuel.html'`
				do
					sed -i "s;doc/grisbi/help;doc/${PF}/help;g" ${i}
				done
	eend 0
}

src_compile() {

	local myconf
	myconf="`use_enable nls`"
	myconf="${myconf} `use_with ofx`"

	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	pkg_setup

	einfo "The first thing you should do is set up the browser command in"
	einfo "preferences after you start up grisbi.  Otherwise you will not"
	einfo "be able to see the help and manuals"
}
