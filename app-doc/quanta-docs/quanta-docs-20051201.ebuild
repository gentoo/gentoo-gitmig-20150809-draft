# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/quanta-docs/quanta-docs-20051201.ebuild,v 1.10 2007/05/13 06:37:17 kumba Exp $

DESCRIPTION="Language documentation files for Quanta."
HOMEPAGE="http://quanta.kdewebdev.org/"
SRC_URI="mirror://gentoo/quanta-css-${PV}.tar.bz2
	mirror://gentoo/quanta-html-${PV}.tar.bz2
	mirror://gentoo/quanta-javascript-${PV}.tar.bz2
	mirror://gentoo/quanta-php-${PV}.tar.bz2
	mysql? ( mirror://gentoo/quanta-mysql5-${PV}.tar.bz2 )"
# These files resemble the unversioned ones at
# http://sourceforge.net/project/showfiles.php?group_id=4113

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="mysql"

S=${WORKDIR}

src_install() {
	dodir /usr/share/apps/quanta/doc

	local docdirs="css html javascript php"
	use mysql && docdirs="${docdirs} mysql5"

	for i in ${docdirs}; do
		cd ${S}/${i}
		cp -R "$i" "$i.docrc" "${D}/usr/share/apps/quanta/doc"
	done
}
