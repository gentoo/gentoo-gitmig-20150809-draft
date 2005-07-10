# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ogdi/ogdi-3.1.4.ebuild,v 1.3 2005/07/10 20:27:26 nerdboy Exp $

DESCRIPTION="open geographical datastore interface"
HOMEPAGE="http://ogdi.sourceforge.net"
SRC_URI="mirror://sourceforge/ogdi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 sparc ~hppa ~alpha ~amd64 ~ppc ~ppc64"
IUSE=""

DEPEND="sci-libs/proj
	sys-libs/zlib
	dev-libs/expat"

src_compile() {
	export TOPDIR="${S}"
	export TARGET="linux"
	export CFG="release"
	export LD_LIBRARY_PATH="${TOPDIR}/bin/${TARGET}"

	econf --with-proj --with-zlib --with-expat || die "econf failed"
	make || die "make failed"
}

src_install() {
	#make \
	#	prefix=${D}usr \
	#	mandir=${D}usr/share/man \
	#	infodir=${D}usr/share/info \
	#	TOPDIR="${S}" TARGET="linux" LD_LIBRARY_PATH="${TOPDIR}/bin/${TARGET}" \
	#	install || die "make install failed"

	einstall TOPDIR="${S}" TARGET="linux" \
		 LD_LIBRARY_PATH="${TOPDIR}/bin/${TARGET}" || die "einstall failed"
	dodoc ChangeLog LICENSE NEWS README VERSION
}
