# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ebuilder/ebuilder-0.4-r1.ebuild,v 1.7 2004/08/26 04:10:01 vapier Exp $

DESCRIPTION="Package Builder for Gentoo Linux"
HOMEPAGE="http://web.inter.nl.net/users/eavdmeer/"
SRC_URI="http://dev.gentoo.org/~genone/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="net-misc/wget"

src_install () {
	dodir /usr/share/ebuilder
	dodir /usr/share/ebuilder/templates

	insinto /usr/share/ebuilder/templates
	doins templates/beginner.ebuild
	doins templates/expert.ebuild

	dosbin ebuilder || die
	doman man/ebuilder.1

	# Install documentation.
	dodoc AUTHORS ChangeLog NEWS README TODO
}
