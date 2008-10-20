# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Atom/XML-Atom-0.28.ebuild,v 1.2 2008/10/20 16:07:19 tove Exp $

MODULE_AUTHOR=MIYAGAWA
inherit perl-module

DESCRIPTION="Atom feed and API implementation"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/Class-Data-Inheritable
	>=dev-perl/XML-LibXML-1.64
	dev-perl/DateTime
	dev-perl/Digest-SHA1
	dev-perl/HTML-Parser
	dev-perl/LWP-Authen-Wsse
	virtual/perl-MIME-Base64"

RDEPEND="${DEPEND}"

SRC_TEST=do
