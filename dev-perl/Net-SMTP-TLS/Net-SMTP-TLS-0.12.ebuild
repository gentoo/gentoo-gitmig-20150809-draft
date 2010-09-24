# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SMTP-TLS/Net-SMTP-TLS-0.12.ebuild,v 1.1 2010/09/24 10:23:11 dev-zero Exp $

EAPI="3"

MODULE_AUTHOR="AWESTHOLM"

inherit perl-module

DESCRIPTION="A SMTP client supporting TLS and AUTH"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl
	dev-perl/Net-SSLeay
	dev-perl/IO-Socket-SSL
	virtual/perl-MIME-Base64
	dev-perl/Digest-HMAC"
RDEPEND="${DEPEND}"

mydoc="Changes README"
SRC_TEST="do"
