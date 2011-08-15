# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IMAP-Simple-SSL/Net-IMAP-Simple-SSL-1.3.ebuild,v 1.1 2011/08/15 14:09:05 patrick Exp $

EAPI=3

MODULE_AUTHOR="CWEST"
inherit perl-module

DESCRIPTION="SSL support for Net::IMAP::Simple"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/IO-Socket-SSL
	dev-perl/Net-IMAP-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
