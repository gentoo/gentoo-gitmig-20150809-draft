# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pypvm/pypvm-0.94.ebuild,v 1.2 2008/03/24 22:21:18 dberkholz Exp $

inherit distutils multilib

DESCRIPTION="Python module that allows interaction with the Parallel Virtual Machine (PVM) package"
HOMEPAGE="http://pypvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND=">=sys-cluster/pvm-3.4.5-r3"
DEPEND="${RDEPEND}"

src_compile() {
	local PVM_PREFIX="/usr/share/pvm3/"
	local PVM_OS
	case $(get_libdir) in
		lib64)	PVM_OS="LINUX64"	;;
		lib)	PVM_OS="LINUX"		;;
	esac

	${python} setup.py build_ext \
		--include-dirs ${PVM_PREFIX}/include \
		--library-dirs ${PVM_PREFIX}/lib/${PVM_OS} \
		|| die
	distutils_src_compile
}
