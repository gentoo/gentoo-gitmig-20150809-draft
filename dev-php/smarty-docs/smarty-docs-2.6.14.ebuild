# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty-docs/smarty-docs-2.6.14.ebuild,v 1.8 2009/02/27 14:55:48 ranger Exp $

KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"

MY_P="Smarty-${PV}-docs"

DESCRIPTION="Documentation for Smarty, a template engine for PHP."
HOMEPAGE="http://smarty.php.net/docs.php"
SRC_URI="http://smarty.php.net/distributions/manual/en/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/manual"

src_install() {
	dohtml -r .
}
