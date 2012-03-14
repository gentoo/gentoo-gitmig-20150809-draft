# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libintl-perl/libintl-perl-1.200.0.ebuild,v 1.2 2012/03/14 20:40:26 jer Exp $

EAPI=4

MODULE_AUTHOR=GUIDO
MODULE_VERSION=1.20
inherit perl-module

DESCRIPTION="Perl internationalization library that aims to be compatible with the Uniforum message translations system"
HOMEPAGE="http://guido-flohr.net/projects/libintl-perl ${HOMEPAGE}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST=do
