# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gomd/gomd-0.1_pre20031115.ebuild,v 1.4 2004/07/15 02:54:25 agriffis Exp $

DESCRIPTION="gomd is a daemon which executes commands and gets information from the nodes of an openMosix cluster. It has to run on every node in order to collect data, and it waits for commands to execute. gomd stands for general openMosix daemon."
HOMEPAGE="http://nongnu.org/gomd"
SRC_URI="mirror://gentoo/${P/0.1_pre}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -alpha -sparc"
IUSE=""

DEPEND="dev-cpp/commoncpp2
	gnome-base/libgtop"

S=${WORKDIR}/gomd

src_compile() {
	./compile.sh --with-libgtop
}

src_install() {
	./install.sh --libgtop
}

pkg_postinst() {
	ldconfig /usr/lib
}
