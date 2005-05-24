# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/clusterssh/clusterssh-2.20.ebuild,v 1.1 2005/05/24 23:40:26 spyderous Exp $

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"
SRC_URI="mirror://sourceforge/clusterssh/clusterssh_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-perl/perl-tk
	dev-perl/Config-Simple"

src_install() {
	cd ${WORKDIR}/clusterssh_${PV}
	dodoc LICENSE
	dobin {cchp,crsh,cssh}
}

