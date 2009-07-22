# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Reload/Apache-Reload-0.10.ebuild,v 1.9 2009/07/22 14:03:18 josejx Exp $

MODULE_AUTHOR=PHRED
inherit perl-module

DESCRIPTION="Perl module for Apache::Reload"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="www-apache/mod_perl"
DEPEND="${RDEPEND}"
