# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/clusterssh/clusterssh-2.20.ebuild,v 1.4 2005/08/13 23:37:45 hansmi Exp $

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"
SRC_URI="mirror://sourceforge/clusterssh/clusterssh_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-perl/perl-tk
	dev-perl/Config-Simple"

src_install() {
	cd ${WORKDIR}/clusterssh_${PV}
	perldoc -onroff -T ./cssh > cssh.1
	dodoc LICENSE
	doman cssh.1
	dobin {cchp,cssh}
	dosym cssh /usr/bin/crsh
}
