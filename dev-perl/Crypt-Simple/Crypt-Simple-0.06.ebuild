# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Simple/Crypt-Simple-0.06.ebuild,v 1.8 2009/10/22 12:23:54 tove Exp $

MODULE_AUTHOR=KASEI
inherit perl-module

DESCRIPTION="Crypt::Simple - encrypt stuff simply"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-perl/FreezeThaw
	dev-lang/perl
	virtual/perl-IO-Compress
	dev-perl/Crypt-Blowfish
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
