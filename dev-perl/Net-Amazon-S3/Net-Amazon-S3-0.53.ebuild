# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Amazon-S3/Net-Amazon-S3-0.53.ebuild,v 1.1 2010/04/23 18:22:30 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=LBROCARD
inherit perl-module

DESCRIPTION="Framework for accessing the Amazon S3 Simple Storage Service"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-perl/Class-Accessor
	>=dev-perl/Class-MOP-0.88
	>=dev-perl/Data-Stream-Bulk-0.06
	dev-perl/Digest-HMAC
	dev-perl/libwww-perl
	virtual/perl-IO
	dev-perl/LWP-UserAgent-Determined
	virtual/perl-MIME-Base64
	>=dev-perl/Moose-0.85
	>=dev-perl/MooseX-StrictConstructor-0.08
	dev-perl/MooseX-Types-DateTimeX
	dev-perl/regexp-common
	dev-perl/XML-LibXML
	dev-perl/URI"
RDEPEND="${DEPEND}"

SRC_TEST=no
