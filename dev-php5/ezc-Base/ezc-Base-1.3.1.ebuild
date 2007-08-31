# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-Base/ezc-Base-1.3.1.ebuild,v 1.2 2007/08/31 14:40:07 jer Exp $

inherit php-pear-lib-r1

DESCRIPTION="The Base package provides the basic infrastructure that all eZ component packages rely on."
HOMEPAGE="http://ez.no/products/ez_components"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""
SRC_URI="http://components.ez.no/get/Base-${PV}.tgz"
DEPEND=">=dev-lang/php-5.1.1
		>=dev-php/PEAR-PEAR-1.4.6"

S="${WORKDIR}/Base-${PV}"
