# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/autodia/autodia-2.08.ebuild,v 1.1 2009/03/21 14:16:59 tove Exp $

MODULE_AUTHOR=TEEJAY
MY_PN=Autodia
MY_P=${MY_PN}-${PV}

inherit perl-app multilib

DESCRIPTION="A modular application that parses source code, XML or data and produces an XML document in Dia format"
HOMEPAGE="http://www.aarontrevena.co.uk/opensource/autodia/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz"

RDEPEND="dev-lang/perl
	dev-perl/Template-Toolkit
	dev-perl/XML-Simple
	graphviz? ( dev-perl/GraphViz )"

DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

S=${WORKDIR}/${MY_P}

src_install() {
	mydoc="FAQ DEVELOP TODO"
	perl-module_src_install
	dosym ${VENDOR_LIB}/autodia.pl /usr/bin/autodia.pl || die
}
