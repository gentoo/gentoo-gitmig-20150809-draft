# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Sender/Email-Sender-0.093110.ebuild,v 1.1 2009/11/10 10:10:48 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="A library for sending email"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Scalar-List-Utils
	virtual/perl-File-Spec
	>=dev-perl/Email-Abstract-3
	dev-perl/Email-Simple
	dev-perl/List-MoreUtils
	dev-perl/Sys-Hostname-Long
	virtual/perl-libnet
	dev-perl/Moose
	dev-perl/Email-Address"
DEPEND="${RDEPEND}
	test? ( dev-perl/Capture-Tiny )"

SRC_TEST=do
