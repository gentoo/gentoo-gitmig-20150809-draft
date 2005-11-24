# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty-docs/smarty-docs-2.6.9-r1.ebuild,v 1.1 2005/11/24 12:33:30 chtekk Exp $

DESCRIPTION="Documentation for Smarty, a template engine for PHP."
HOMEPAGE="http://smarty.php.net/docs.php"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~hppa ~ppc ~sparc ~x86 ~amd64"

MY_P="Smarty-${PV}-docs"
SRC_URI="http://smarty.php.net/distributions/manual/en/${MY_P}.tar.gz"
S="${WORKDIR}/manual"

src_install() {
	dohtml -r .
}
