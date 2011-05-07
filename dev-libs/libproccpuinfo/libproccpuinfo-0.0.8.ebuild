# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libproccpuinfo/libproccpuinfo-0.0.8.ebuild,v 1.2 2011/05/07 04:01:12 mattst88 Exp $

inherit cmake-utils

DESCRIPTION="architecture independent C API for reading /proc/cpuinfo"
HOMEPAGE="https://savannah.nongnu.org/projects/proccpuinfo/"
SRC_URI="http://download.savannah.nongnu.org/releases/proccpuinfo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~x86"
IUSE=""

DEPEND=">=sys-devel/flex-2.5.33"
RDEPEND=""

DOCS="AUTHORS ChangeLog HACKING README THANKS TODO"

CMAKE_IN_SOURCE_BUILD="yes"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s#DESTINATION lib#DESTINATION $(get_libdir)#" -i CMakeLists.txt
}
