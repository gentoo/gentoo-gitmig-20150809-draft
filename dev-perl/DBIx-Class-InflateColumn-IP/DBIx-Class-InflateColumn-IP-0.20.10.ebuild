# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-InflateColumn-IP/DBIx-Class-InflateColumn-IP-0.20.10.ebuild,v 1.1 2011/08/31 13:39:23 tove Exp $

EAPI=4

MODULE_AUTHOR=ILMARI
MODULE_VERSION=0.02001
inherit perl-module

DESCRIPTION="Auto-create NetAddr::IP objects from columns"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/NetAddr-IP
	>=dev-perl/DBIx-Class-0.08107"
RDEPEND="${DEPEND}"
