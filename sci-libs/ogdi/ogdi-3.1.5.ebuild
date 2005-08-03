# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ogdi/ogdi-3.1.5.ebuild,v 1.4 2005/08/03 21:46:13 nerdboy Exp $

inherit toolchain-funcs

DESCRIPTION="OGDI - Open Geographical Datastore Interface, a GIS support library"
HOMEPAGE="http://ogdi.sourceforge.net"
SRC_URI="mirror://sourceforge/ogdi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sci-libs/proj
	sys-libs/zlib
	dev-libs/expat"

src_compile() {
	export TOPDIR="${S}"
	export TARGET=`uname`
	export CFG="release"
	export LD_LIBRARY_PATH=$TOPDIR/bin/${TARGET}

	econf --with-proj=/usr --with-projlib="-L/usr/$(get_libdir) -lproj" \
	    --with-zlib --with-expat || die "econf failed"
	make || die "make failed"
}

src_install() {
	mv ${S}/bin/Linux/*.so ${S}/lib/Linux/. || die "lib move failed"
	dobin ${S}/bin/Linux/*
	insinto /usr/include
	doins ogdi/include/ecs.h ogdi/include/ecs_util.h
	dolib.so lib/Linux/*.so
	dosym libogdi31.so /usr/$(get_libdir)/libogdi.so || die "symlink failed"
	dodoc ChangeLog LICENSE NEWS README VERSION
}
