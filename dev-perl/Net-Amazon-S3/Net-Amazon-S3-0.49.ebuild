# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Amazon-S3/Net-Amazon-S3-0.49.ebuild,v 1.2 2009/01/15 11:10:39 tove Exp $

MODULE_AUTHOR=LBROCARD
inherit perl-module

DESCRIPTION="Framework for accessing the Amazon S3 Simple Storage Service"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Class-Accessor
	dev-perl/Data-Stream-Bulk
	dev-perl/Digest-HMAC
	dev-perl/libwww-perl
	virtual/perl-IO
	dev-perl/LWP-UserAgent-Determined
	virtual/perl-MIME-Base64
	dev-perl/Moose
	dev-perl/MooseX-StrictConstructor
	dev-perl/regexp-common
	dev-perl/XML-LibXML
	dev-perl/URI"

SRC_TEST=no
