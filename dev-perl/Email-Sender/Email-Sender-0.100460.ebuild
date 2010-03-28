# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Sender/Email-Sender-0.100460.ebuild,v 1.2 2010/03/28 13:58:11 mr_bones_ Exp $

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
	dev-perl/Throwable
	dev-perl/Try-Tiny
	virtual/perl-libnet
	dev-perl/Moose
	dev-perl/Email-Address"
DEPEND="${RDEPEND}
	test? ( dev-perl/Capture-Tiny
			dev-perl/Test-MockObject )"

SRC_TEST=do
