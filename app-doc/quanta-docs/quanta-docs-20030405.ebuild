# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/quanta-docs/quanta-docs-20030405.ebuild,v 1.9 2004/11/17 11:29:45 kloeri Exp $

S=${WORKDIR}
DESCRIPTION="Lots of docs for quanta"
SRC_URI="mirror://sourceforge/quanta/css.tar.bz2
	mirror://sourceforge/quanta/html.tar.bz2
	mirror://sourceforge/quanta/javascript.tar.bz2
	mirror://sourceforge/quanta/php.tar.bz2
	mirror://sourceforge/quanta/php_manual_en_20030401.tar.bz2
	mysql? ( mirror://sourceforge/quanta/quantadoc-mysql-20030405.tar.bz2 )"

HOMEPAGE="http://quanta.sourceforge.net"

SLOT="0"
IUSE="mysql"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64 ppc64 hppa alpha"

src_install() {
	dodir /usr/share/apps/quanta/doc
	for i in css html javascript php ; do
		cd ${S}/${i}
		cp -R $i $i.docrc ${D}/usr/share/apps/quanta/doc
	done
}
