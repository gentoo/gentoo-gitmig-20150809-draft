# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-5.428.ebuild,v 1.2 2010/10/29 16:05:38 grobian Exp $

EAPI=2

MODULE_AUTHOR=DONEILL
inherit perl-module

DESCRIPTION="A Perl module for parsing and creating MIME entities"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd ~ppc-macos"
IUSE=""

RDEPEND=">=dev-perl/IO-stringy-2.108
	>=virtual/perl-MIME-Base64-3.05
	virtual/perl-libnet
	dev-perl/URI
	virtual/perl-Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/MailTools
	virtual/perl-File-Temp"
DEPEND="${RDEPEND}"

SRC_TEST="do"
