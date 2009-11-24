# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-2.225.ebuild,v 1.1 2009/11/24 07:47:33 robbat2 Exp $

EAPI=2

MODULE_AUTHOR="RJBS"
inherit perl-module

DESCRIPTION="Mail sorting/delivery module for Perl."

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/MIME-tools
	>=dev-perl/MailTools-1.15
	virtual/perl-libnet
	dev-perl/File-Tempdir
	>=dev-perl/File-HomeDir-0.61"
DEPEND="${RDEPEND}"

SRC_TEST=do
