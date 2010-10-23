# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GSSAPI/GSSAPI-0.28.ebuild,v 1.7 2010/10/23 08:41:02 ssuominen Exp $

EAPI=3

MODULE_AUTHOR=AGROLMS
inherit perl-module

DESCRIPTION="GSSAPI - Perl extension providing access to the GSSAPIv2 library"

SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ppc ppc64 s390 sh sparc x86"
IUSE="test"

RDEPEND="virtual/krb5"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
