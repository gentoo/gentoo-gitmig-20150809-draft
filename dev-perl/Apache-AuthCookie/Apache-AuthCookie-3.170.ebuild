# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-AuthCookie/Apache-AuthCookie-3.170.ebuild,v 1.1 2011/01/20 07:01:27 tove Exp $

EAPI=3

MODULE_AUTHOR=MSCHOUT
MODULE_VERSION=3.17
inherit perl-module

DESCRIPTION="Perl Authentication and Authorization via cookies"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND=">=www-apache/mod_perl-2
	>=dev-perl/Apache-Test-1.32"
DEPEND="${RDEPEND}"
