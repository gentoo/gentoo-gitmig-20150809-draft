# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Db/Horde_Db-1.0.5.ebuild,v 1.1 2011/09/17 12:08:47 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde Database Libraries"
LICENSE="BSD"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/get/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0
	=dev-php/Horde_Date-1*
	=dev-php/Horde_Exception-1*
	=dev-php/Horde_Support-1*"
RDEPEND="${DEPEND}"

src_install() {
	php-pear-r1_src_install

	cd "${D}/usr/bin/" || die
	mv horde-db-migrate horde-db-migrate-base || die

	elog "The horde-db-migrate(1) tool has been installed as horde-db-migrate-base"
	elog "as www-apps/horde provides a similiar script with the same name."
}
