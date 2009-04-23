# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/phoronix-test-suite/phoronix-test-suite-1.8.0.ebuild,v 1.2 2009/04/23 14:06:42 patrick Exp $

EAPI=2

DESCRIPTION="Phoronix's comprehensive, cross-platform testing and benchmark suite"
HOMEPAGE="http://www.phoronix-test-suite.com"
SRC_URI="http://www.phoronix-test-suite.com/download.php?file=${P} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gd gtk"

DEPEND=""
RDEPEND="dev-lang/php:5[cli,gd?]
		gtk? ( dev-php5/php-gtk )"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e "s,export PTS_DIR=\`pwd\`,export PTS_DIR=\"/usr/share/${PN}\"," \
		phoronix-test-suite
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r {pts,pts-core}

	doman documentation/man-pages/phoronix-test-suite.1
	dodoc AUTHORS CHANGE-LOG
	dohtml README.html

	exeinto /usr/bin
	doexe phoronix-test-suite

	fperms a+x /usr/share/${PN}/pts-core/scripts/launch-browser.sh
	fperms a+x /usr/share/${PN}/pts-core/test-libraries/*.sh
	fperms a+x /usr/share/${PN}/pts/distro-scripts/install-gentoo-packages.sh
}
