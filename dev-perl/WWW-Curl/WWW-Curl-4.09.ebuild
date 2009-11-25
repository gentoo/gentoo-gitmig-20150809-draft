# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Curl/WWW-Curl-4.09.ebuild,v 1.5 2009/11/25 10:22:43 maekke Exp $

EAPI=2

MODULE_AUTHOR="SZBALINT"
inherit perl-module

DESCRIPTION="Perl extension interface for libcurl"

LICENSE="|| ( MPL-1.0 MPL-1.1 MIT )"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

# online tests
SRC_TEST="no"
