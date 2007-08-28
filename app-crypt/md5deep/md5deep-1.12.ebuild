# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md5deep/md5deep-1.12.ebuild,v 1.5 2007/08/28 09:55:05 nixnut Exp $

DESCRIPTION="Expanded md5sum program that has recursive and comparison options."
HOMEPAGE="http://md5deep.sourceforge.net"
SRC_URI="mirror://sourceforge/md5deep/${P}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos sparc x86"
IUSE=""
DEPEND=""

src_compile() {
	sed -i -e "s:CFLAGS[ ]*=:CFLAGS = ${CFLAGS}:g" Makefile

	case ${CHOST} in
		*-darwin*) BUILDTARGET="mac" ;;
		*-linux*)  BUILDTARGET="linux" ;;

		# Let it fallback to general "unix" when not using linux exactly
		*)         BUILDTARGET="unix" ;;
	esac

	emake "${BUILDTARGET}" || die "make failed"
}

src_install() {
	make BIN="${D}/usr/bin" MAN="${D}/usr/share/man/man1" install || die "make install failed"
	dodoc CHANGES README
}
