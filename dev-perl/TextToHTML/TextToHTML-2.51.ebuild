# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TextToHTML/TextToHTML-2.51.ebuild,v 1.2 2009/10/22 13:10:00 tove Exp $

MY_PN=txt2html
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=RUBYKAT
inherit perl-module

DESCRIPTION="HTML::TextToHTML - convert plain text file to HTML"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/YAML-Syck
	virtual/perl-Getopt-Long
	dev-perl/Getopt-ArgvFile"
DEPEND="${RDEPEND}"

SRC_TEST="do"
