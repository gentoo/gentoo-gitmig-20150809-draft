# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_CSSML/PEAR-XML_CSSML-1.1-r2.ebuild,v 1.6 2005/11/22 19:16:33 corsair Exp $

inherit php-pear

DESCRIPTION="A template system for generating cascading style sheets (CSS)"
LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	sed 's/role="ext"/role="php"/g' -i ${WORKDIR}/package.xml
}
