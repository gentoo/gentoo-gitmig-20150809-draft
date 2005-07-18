# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/asterisk-perl/asterisk-perl-0.08.ebuild,v 1.1 2005/07/18 19:44:17 stkn Exp $

inherit eutils perl-module

DESCRIPTION="Perl bindings for the Asterisk AGI"
HOMEPAGE="http://asterisk.gnuinter.net/"
SRC_URI="http://asterisk.gnuinter.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-misc/asterisk
	dev-lang/perl"

mydoc="README CHANGES examples/*"

pkg_setup() {
	einfo "Checking your perl installation..."
	if built_with_use "dev-lang/perl" minimal; then
		eerror "Your perl was built with the 'minimal' USE flag."
		eerror "asterisk-perl will not build in these conditions."
		eerror "Re-emerge dev-lang/perl with the 'minimal' flag unset."
		die "perl with 'minimal' use flag found"
	fi
	einfo "Everything is fine, continuing..."
}
