# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-OpenID-Consumer/Net-OpenID-Consumer-1.02.ebuild,v 1.1 2008/10/22 09:46:04 tove Exp $

MODULE_AUTHOR=MART
inherit perl-module

DESCRIPTION="Library for consumers of OpenID identities"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/crypt-dh
	dev-perl/XML-Simple
	dev-perl/Digest-SHA1
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/URI-Fetch
	virtual/perl-Time-Local
	virtual/perl-MIME-Base64"

SRC_TEST=do
