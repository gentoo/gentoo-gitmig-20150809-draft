# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/clusterssh/clusterssh-9999.ebuild,v 1.1 2010/11/20 09:40:47 jlec Exp $

EAPI=2

inherit git perl-module

EGIT_REPO_URI="git://clusterssh.git.sourceforge.net/gitroot/clusterssh/clusterssh"

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	dev-perl/Test-Trap
	dev-perl/perl-tk
	dev-perl/Config-Simple
	dev-perl/X11-Protocol
	x11-apps/xlsfonts"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
	dev-perl/Test-Pod"

SRC_TEST="do parallel"

src_unpack() {
	git_src_unpack
	perl-module_src_unpack
}

src_prepare() {
	git_src_prepare
	perl-module_src_prepare
}
