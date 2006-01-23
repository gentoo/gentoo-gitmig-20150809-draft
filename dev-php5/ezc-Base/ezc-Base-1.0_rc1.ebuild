# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-Base/ezc-Base-1.0_rc1.ebuild,v 1.1 2006/01/23 14:41:37 sebastian Exp $

inherit php-pear-lib-r1

DESCRIPTION="The Base package provides the basic infrastructure that all eZ component packages rely on."
HOMEPAGE="http://ez.no/products/ez_components"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#SRC_URI="http://components.ez.no/get/Base-${PV}.tgz"
SRC_URI="http://components.ez.no/get/Base-1.0RC1.tgz"
DEPEND=">=dev-lang/php-5.1.1
		>=dev-php/PEAR-PEAR-1.4.6"

#S="${WORKDIR}/Base-${PV}"
S="${WORKDIR}/Base-1.0RC1"
