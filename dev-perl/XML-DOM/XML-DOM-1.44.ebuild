# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.44.ebuild,v 1.17 2010/03/06 14:47:36 armin76 Exp $

EAPI=2

MODULE_AUTHOR=TJMATHER
inherit perl-module

DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/libwww-perl
	>=dev-perl/libxml-perl-0.07
	>=dev-perl/XML-Parser-2.30
	dev-perl/XML-RegExp"
DEPEND="${RDEPEND}"
