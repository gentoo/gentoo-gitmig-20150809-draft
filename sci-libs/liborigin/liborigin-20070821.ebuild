# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/liborigin/liborigin-20070821.ebuild,v 1.1 2007/09/20 15:39:43 bicatali Exp $

inherit multilib

MY_P=${PN}-${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="A library for reading OriginLab OPJ project files"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/liborigin/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

SLOT="0"
IUSE=""

DEPEND="!<sci-visualization/labplot-1.5.1.6"
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	# CC is defined as a C++ compiler in the Makefile
	sed -i \
		-e '/^CC.*=/d' \
		-e 's/CC/CXX/g' \
		-e 's/CFLAGS.*=/CXXFLAGS +=/' \
		-e 's/CFLAGS/CXXFLAGS/g' \
		-e '/ldconfig/d' \
		"${S}"/Makefile.LINUX \
		|| die "sed Makefile failed"
}

src_compile() {
	emake -j1 LIBEXT=$(get_libdir) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README FORMAT || die "dodoc failed"
}
