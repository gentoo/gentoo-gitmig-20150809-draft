# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/quanta-docs/quanta-docs-20030405.ebuild,v 1.13 2005/07/02 02:59:44 hardave Exp $

DESCRIPTION="Lots of docs for quanta"
HOMEPAGE="http://quanta.sourceforge.net"
SRC_URI="mirror://sourceforge/quanta/css.tar.bz2
	mirror://sourceforge/quanta/html.tar.bz2
	mirror://sourceforge/quanta/javascript.tar.bz2
	mirror://sourceforge/quanta/php.tar.bz2
	mirror://sourceforge/quanta/php_manual_en_20030401.tar.bz2
	mysql? ( mirror://sourceforge/quanta/quantadoc-mysql-20030405.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="mysql"

S=${WORKDIR}

src_install() {
	dodir /usr/share/apps/quanta/doc
	for i in css html javascript php ; do
		cd ${S}/${i}
		cp -R $i $i.docrc ${D}/usr/share/apps/quanta/doc
	done
}
