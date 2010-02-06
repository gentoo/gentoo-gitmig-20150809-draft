# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Handler-YAWriter/XML-Handler-YAWriter-0.23-r1.ebuild,v 1.20 2010/02/06 13:58:28 tove Exp $

EAPI=2

MODULE_AUTHOR=KRAEHE
inherit perl-module

DESCRIPTION="A Perl module providing a simple API to parsed XML instances"

LICENSE="GPL-2" # GPL
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND=">=dev-perl/libxml-perl-0.07-r1"
DEPEND="${RDEPEND}"
