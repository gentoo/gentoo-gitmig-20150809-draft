# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS-Feed/XML-RSS-Feed-2.320.ebuild,v 1.1 2011/01/14 09:59:43 tove Exp $

MODULE_AUTHOR=JBISBEE
MODULE_VERSION=2.32
inherit perl-module

DESCRIPTION="Persistant XML RSS Encapsulation"

SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Parser
	dev-perl/XML-RSS
	dev-perl/Clone
	virtual/perl-Time-HiRes
	dev-perl/URI
	virtual/perl-Digest-MD5
	dev-lang/perl"
