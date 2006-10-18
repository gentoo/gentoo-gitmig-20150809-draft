# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config-wrapper/java-config-wrapper-0.12-r1.ebuild,v 1.1 2006/10/18 03:37:56 nichoj Exp $

inherit base eutils
DESCRIPTION="Wrapper for java-config"
HOMEPAGE="http://www.gentoo.org/proj/en/java"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ia64 ppc ppc64 x86 ~x86-fbsd"
DEPEND="!<dev-java/java-config-1.3"
RDEPEND="app-portage/portage-utils"

IUSE=""

# Patch to improve output of generation_1_system_vm
PATCHES="${FILESDIR}/${P}-generation_1_system_vm.patch"

src_compile() {
	:;
}

src_install() {
	dobin src/shell/*
}
