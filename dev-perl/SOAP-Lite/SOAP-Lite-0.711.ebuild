# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP-Lite/SOAP-Lite-0.711.ebuild,v 1.6 2010/12/29 01:24:05 ranger Exp $

MODULE_AUTHOR="MKUTTER"
inherit perl-module eutils

DESCRIPTION="Simple and lightweight interface to the SOAP protocol (sic) both on client and server side"

IUSE="jabber ssl"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86"

myconf="${myconf} --noprompt"

# TESTS ARE DISABLED ON PURPOSE
# This module attempts to access an external website for validation
# of the MIME::Parser - not only is that bad practice in general,
# but in this particular case the external site isn't even valid anymore# -mpc
# 24/10/04
SRC_TEST="do"

DEPEND="dev-perl/XML-Parser
	dev-perl/libwww-perl
	virtual/perl-libnet
	dev-perl/MIME-Lite
	virtual/perl-MIME-Base64
	ssl? ( dev-perl/Crypt-SSLeay )
	jabber? ( dev-perl/Net-Jabber )
	ssl? ( dev-perl/IO-Socket-SSL )
	virtual/perl-IO-Compress
	>=dev-perl/MIME-tools-5.413
	virtual/perl-version
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# The author of this module put a dep for MIME::Parser 6.X - but the6.X
	# release of MIME::Parser was a mistake during a change in maintainers on
	# cpan. This patch alters the dependancy to the "real" stable version of
	# MIME::Parser.
	epatch "${FILESDIR}"/SOAP-Lite-0.710.08.patch
}

src_test() {
	has_version '>=www-apache/mod_perl-2' && export MOD_PERL_API_VERSION=2
	perl-module_src_test
}
