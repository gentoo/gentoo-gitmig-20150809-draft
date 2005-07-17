# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/clusterssh/clusterssh-3.17.1.ebuild,v 1.1 2005/07/17 12:40:31 voxus Exp $

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"
SRC_URI="mirror://sourceforge/clusterssh/clusterssh-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-perl/perl-tk
	dev-perl/Config-Simple
	dev-perl/X11-Protocol"

src_compile() {
	econf || die "configuration failed"
	emake || die "compiling failed"
}

src_install() {
	cd ${S}
	dodoc AUTHORS COPYING INSTALL NEWS README THANKS
	dobin src/cssh
	doman src/cssh.1
}
