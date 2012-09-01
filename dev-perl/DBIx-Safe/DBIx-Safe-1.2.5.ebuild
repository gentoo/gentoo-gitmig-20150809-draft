# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Safe/DBIx-Safe-1.2.5.ebuild,v 1.1 2012/09/01 02:21:28 patrick Exp $

EAPI=4

MODULE_AUTHOR=TURNSTEP
MODULE_VERSION=1.2.5
inherit perl-module eutils

DESCRIPTION="Safer access to your database through a DBI database handle"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/DBI"
DEPEND="${RDEPEND}"
