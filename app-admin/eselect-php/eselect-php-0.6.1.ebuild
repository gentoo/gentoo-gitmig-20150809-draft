# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-php/eselect-php-0.6.1.ebuild,v 1.7 2010/12/20 17:45:10 ranger Exp $

EAPI=3

DESCRIPTION="PHP eselect module"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://olemarkus.org/~olemarkus/gentoo/eselect-php-${PV}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=app-admin/eselect-1.2.4
		!app-admin/php-toolkit"
RDEPEND="${DEPEND}"

src_install() {
	mv eselect-php-${PV} php.eselect
	insinto /usr/share/eselect/modules/
	doins php.eselect
}
