# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ebuilder/ebuilder-0.4-r1.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Package Builder for Gentoo Linux"
SRC_URI="http://www.disinformation.ca/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.disinformation.ca/gentoo"
DEPEND="net-misc/wget"
RDEPEND="$DEPEND"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	echo "Nothing to compile for ${P}."
}

src_install () {
	dodir /usr/share/ebuilder
	dodir /usr/share/ebuilder/templates

	insinto /usr/share/ebuilder/templates
	doins templates/beginner.ebuild
	doins templates/expert.ebuild

	dosbin ebuilder
	doman man/ebuilder.1

	# Install documentation.
	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
