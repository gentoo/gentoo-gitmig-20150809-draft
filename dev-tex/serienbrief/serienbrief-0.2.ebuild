# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/serienbrief/serienbrief-0.2.ebuild,v 1.1 2006/07/25 09:18:26 nattfodd Exp $

DESCRIPTION="Easy creation of form letters written in LaTeX"
HOMEPAGE="http://www.nasauber.de/downloads/?programm=serienbrief"
SRC_URI="http://www.nasauber.de/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~x86"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.8.6
	>=perl-core/Getopt-Long-2.34
	>=dev-perl/Term-ANSIColor-1.08
	>=dev-perl/Locale-gettext-1.01
	virtual/tetex"

src_install() {
	dobin serienbrief
	doman serienbrief.1
	insinto /usr/share/locale/de/LC_MESSAGES
	doins serienbrief.mo
	dodoc changelog example/*
}
