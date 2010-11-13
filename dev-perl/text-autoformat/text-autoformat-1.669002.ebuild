# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-autoformat/text-autoformat-1.669002.ebuild,v 1.6 2010/11/13 20:12:54 armin76 Exp $

EAPI=2

MY_PN=Text-Autoformat
MY_P=${MY_PN}-${PV}
MODULE_AUTHOR=DCONWAY
inherit perl-module

DESCRIPTION="Automatic text wrapping and reformatting"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/text-reform-1.11
	virtual/perl-version"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

S=${WORKDIR}/${MY_P}
SRC_TEST=do
