# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/autodia/autodia-2.03.ebuild,v 1.1 2007/04/15 10:52:11 mcummings Exp $

inherit perl-app multilib

MY_P="Autodia-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A modular application that parses source code, XML or data and produces an XML document in Dia format"
HOMEPAGE="http://www.aarontrevena.co.uk/opensource/autodia/"
SRC_URI="http://www.aarontrevena.co.uk/opensource/autodia/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Template-Toolkit
	dev-perl/XML-Simple
	graphviz? ( dev-perl/GraphViz )
	java? ( dev-perl/Inline-Java )"

DEPEND="${RDEPEND}
	dev-perl/module-build"

src_install() {
	perl-module_src_install
	local version
	eval `perl '-V:version'`
	perl_version=${version}
	local myarch
	eval `perl '-V:archname'`
	myarch=${archname}
	dodir /usr/bin
	dosym /usr/$(get_libdir)/perl5/vendor_perl/${perl_version}/autodia_java.pl /usr/bin/autodia_java.pl
	dosym /usr/$(get_libdir)/perl5/vendor_perl/${perl_version}/autodia.pl /usr/bin/autodia.pl
}
