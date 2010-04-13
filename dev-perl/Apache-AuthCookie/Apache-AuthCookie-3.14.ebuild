# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-AuthCookie/Apache-AuthCookie-3.14.ebuild,v 1.1 2010/04/13 11:51:56 tove Exp $

EAPI=2

MODULE_AUTHOR=MSCHOUT
inherit perl-module

DESCRIPTION="Perl Authentication and Authorization via cookies"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND=">=www-apache/mod_perl-2"
DEPEND="${RDEPEND}"
