# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MailTools/MailTools-2.07.ebuild,v 1.2 2010/12/07 04:43:15 mattst88 Exp $

EAPI=3

MODULE_AUTHOR=MARKOV
inherit perl-module

DESCRIPTION="Manipulation of electronic mail addresses"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=virtual/perl-libnet-1.0703
	dev-perl/TimeDate"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
