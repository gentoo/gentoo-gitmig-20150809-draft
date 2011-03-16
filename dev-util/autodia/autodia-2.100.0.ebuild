# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/autodia/autodia-2.100.0.ebuild,v 1.1 2011/03/16 07:47:57 tove Exp $

EAPI=3

MY_PN=Autodia
MODULE_AUTHOR=TEEJAY
MODULE_VERSION=2.10
inherit perl-app multilib

DESCRIPTION="A application that parses source code, XML or data and produces an XML document in Dia format"
HOMEPAGE="http://www.aarontrevena.co.uk/opensource/autodia/ ${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz"

RDEPEND="
	dev-perl/Template-Toolkit
	dev-perl/XML-Simple
	graphviz? ( dev-perl/GraphViz )"

DEPEND="${RDEPEND}"

SRC_TEST=do

src_install() {
	mydoc="FAQ DEVELOP TODO"
	perl-module_src_install
	dosym ${VENDOR_LIB}/autodia.pl /usr/bin/autodia.pl || die
}
