# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Stream/XML-Stream-1.230.0.ebuild,v 1.2 2011/12/01 16:12:06 tove Exp $

EAPI=4

MODULE_AUTHOR=DAPATRICK
MODULE_VERSION=1.23
inherit perl-module

DESCRIPTION="Creates and XML Stream connection and parses return data"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl"

RDEPEND="dev-perl/Authen-SASL
	dev-perl/Net-DNS
	ssl? ( dev-perl/IO-Socket-SSL )
	virtual/perl-MIME-Base64"
#DEPEND="${RDEPEND}"

SRC_TEST="online"
