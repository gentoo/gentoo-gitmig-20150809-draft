# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/SabreAMF/SabreAMF-1.0.174.ebuild,v 1.1 2008/01/04 13:24:00 jokey Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="SabreAMF is a Flash Remoting server and client for PHP."
HOMEPAGE="http://osflash.org/sabreamf"
SRC_URI="http://sabreamf.googlecode.com/files/${P}.tgz"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/php-5.2.0"
