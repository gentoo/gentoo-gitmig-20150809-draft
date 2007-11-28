# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/liborigin/liborigin-20071119.ebuild,v 1.1 2007/11/28 22:49:44 bicatali Exp $

inherit multilib

DESCRIPTION="A library for reading OriginLab OPJ project files"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/liborigin/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

SLOT="0"
IUSE=""

DEPEND="!<sci-visualization/labplot-1.5.1.6"
RESTRICT="test"

src_unpack() {
	unpack ${A}
	# CC is defined as a C++ compiler in the Makefile
	sed -i \
		-e '/^CC.*=/d' \
		-e 's/CC/CXX/g' \
		-e 's/CFLAGS.*=/CXXFLAGS +=/' \
		-e 's/CFLAGS/CXXFLAGS/g' \
		-e '/ldconfig/d' \
		-e "s/mkdir -p lib/mkdir -p $(get_libdir)/g" \
		-e "s/\`.\/lib-arch.sh\`/$(get_libdir)/g" \
		-e "s/lib\//$(get_libdir)\//g" \
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
