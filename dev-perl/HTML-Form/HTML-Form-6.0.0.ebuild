# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Form/HTML-Form-6.0.0.ebuild,v 1.3 2011/06/13 00:06:21 mattst88 Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.00
inherit perl-module

DESCRIPTION="Class that represents an HTML form element"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~m68k ~mips ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/HTTP-Message-6.0.0
	>=dev-perl/URI-1.10
	dev-perl/HTML-Parser
	>=virtual/perl-Encode-2
"
DEPEND="${RDEPEND}"
