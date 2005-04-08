# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty-docs/smarty-docs-2.6.9.ebuild,v 1.4 2005/04/08 20:27:25 gmsoft Exp $

MY_P=Smarty-${PV}-docs
DESCRIPTION="A template engine for PHP"
HOMEPAGE="http://smarty.php.net/"
SRC_URI="http://smarty.php.net/distributions/manual/en/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="alpha hppa ppc ~sparc x86 amd64"
DEPEND=""

S=${WORKDIR}/manual

src_install() {
	dohtml -r .
}
