# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/yamlrb/yamlrb-0.47.ebuild,v 1.1 2003/01/31 23:11:10 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Machine parsable data serialization format designed for human readability."
SRC_URI="mirror://sourceforge/yaml4r/${P}.tar.gz"
HOMEPAGE="http://yaml4r.sourceforge.net/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ruby-1.6"

src_install() {
	INSTALL_DIR=`ruby -e 'require "rbconfig"; puts Config::CONFIG["sitelibdir"]'`
	mkdir -p ${D}${INSTALL_DIR}

	cp src/yaml.rb ${D}${INSTALL_DIR}/
	cp src/okay.rb ${D}${INSTALL_DIR}/
	cp -dr src/okay/ ${D}${INSTALL_DIR}/

	dodoc [A-Z]*
}
