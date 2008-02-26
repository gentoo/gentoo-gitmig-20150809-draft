# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/SabreAMF/SabreAMF-1.1.187.ebuild,v 1.1 2008/02/26 16:43:38 armin76 Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="SabreAMF is a Flash Remoting server and client for PHP."
HOMEPAGE="http://osflash.org/sabreamf"
SRC_URI="http://sabreamf.googlecode.com/files/${P}.tgz"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/php-5.2.0"
