# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/quanta-docs/quanta-docs-20041123.ebuild,v 1.7 2005/08/23 03:09:13 agriffis Exp $

DESCRIPTION="Language documentation files for quanta."
HOMEPAGE="http://quanta.kdewebdev.org/"
SRC_URI="mirror://gentoo/${PN}-css-${PV}.tar.bz2
	mirror://gentoo/${PN}-html-${PV}.tar.bz2
	mirror://gentoo/${PN}-javascript-${PV}.tar.bz2
	mirror://gentoo/${PN}-php-${PV}.tar.bz2
	mysql? ( mirror://gentoo/${PN}-mysql-${PV}.tar.bz2 )"
# These files are snapshots based respectively on:
#  mirror://sourceforge/quanta/css.tar.bz2
#  mirror://sourceforge/quanta/html.tar.bz2
#  mirror://sourceforge/quanta/javascript.tar.bz2
#  mirror://sourceforge/quanta/php_manual_en_20030401.tar.bz2
#  mirror://sourceforge/quanta/mysql-20030405.tar.bz2

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="mysql"

S=${WORKDIR}

src_install() {
	dodir /usr/share/apps/quanta/doc

	local docdirs="css html javascript php"
	use mysql && docdirs="${docdirs} mysql"

	for i in ${docdirs}; do
		cd "${S}/${i}"
		cp -R "$i" "$i.docrc" "${D}/usr/share/apps/quanta/doc"
	done
}
