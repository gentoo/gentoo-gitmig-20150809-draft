# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-DAV/HTTP-DAV-0.440.0.ebuild,v 1.1 2011/06/25 09:25:55 tove Exp $

EAPI=4

MODULE_AUTHOR=OPERA
MODULE_VERSION=0.44
inherit perl-module

DESCRIPTION="A WebDAV client library for Perl5"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/XML-DOM"
RDEPEND="${DEPEND}"

SRC_TEST="do"
