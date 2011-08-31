# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Find/Email-Find-0.100.0.ebuild,v 1.1 2011/08/31 11:01:48 tove Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Find RFC 822 email addresses in plain text"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/MailTools
	dev-perl/Email-Valid
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
