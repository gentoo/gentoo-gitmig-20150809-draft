# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/clusterssh/clusterssh-2.14.ebuild,v 1.2 2004/07/15 01:05:25 agriffis Exp $

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"
SRC_URI="mirror://sourceforge/clusterssh/clusterssh_${PV}_Beta.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-perl/perl-tk
	dev-perl/Config-Simple"

src_install() {
	cd ${WORKDIR}
	dodoc LICENSE
	dobin {cchp,crsh,cssh}
}

