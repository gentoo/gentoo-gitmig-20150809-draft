# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_CSSML/PEAR-XML_CSSML-1.1-r2.ebuild,v 1.2 2004/08/03 17:11:11 agriffis Exp $

inherit php-pear

DESCRIPTION="A template system for generating cascading style sheets (CSS)"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~sparc alpha ppc ia64"
IUSE=""

src_unpack() {
	unpack ${A}
	sed 's/role="ext"/role="php"/g' -i ${WORKDIR}/package.xml
}
