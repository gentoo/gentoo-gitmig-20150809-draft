# Copyright 2007-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/smem/smem-20071119.ebuild,v 1.1 2008/06/18 17:07:55 flameeyes Exp $

DESCRIPTION="A tool to parse smaps statistics"
HOMEPAGE="http://www.contrib.andrew.cmu.edu/~bmaurer/memory/"
SRC_URI="mirror://gentoo/smem.pl.${PV}.bz2"

IUSE=""

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-lang/perl
	dev-perl/Class-Member
	dev-perl/Linux-Smaps"

src_compile() { :; }

src_install() {
	newbin smem.pl.${PV} smem
}
