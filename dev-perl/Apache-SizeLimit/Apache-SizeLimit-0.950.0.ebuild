# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-SizeLimit/Apache-SizeLimit-0.950.0.ebuild,v 1.1 2011/09/01 13:37:44 tove Exp $

EAPI=4

MODULE_AUTHOR=PHRED
MODULE_VERSION=0.95
inherit perl-module

DESCRIPTION="Graceful exit for large children"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# mod_perl < 2.0.5 bundles Apache-SizeLimit
DEPEND="dev-perl/Linux-Pid
	!<www-apache/mod_perl-2.0.5
	>=www-apache/mod_perl-2.0.5"
RDEPEND="${DEPEND}"

SRC_TEST="do"

# https://rt.cpan.org/Public/Bug/Display.html?id=66894
PATCHES=( "${FILESDIR}/${PN}-0.95-Fix_Linux-Smaps_detection.patch" )
