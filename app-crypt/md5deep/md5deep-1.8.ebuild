# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md5deep/md5deep-1.8.ebuild,v 1.4 2005/12/31 12:32:27 flameeyes Exp $

DESCRIPTION="Expanded md5sum program that has recursive and comparison options."
HOMEPAGE="http://md5deep.sourceforge.net"
SRC_URI="mirror://sourceforge/md5deep/${P}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~ppc-macos"
IUSE=""
DEPEND=""

src_compile() {
	sed -i -e "s:-Wall -O2:\$(CFLAGS):g" Makefile

	case ${CHOST} in
		*-darwin*) BUILDTARGET="mac" ;;
		*-linux*)  BUILDTARGET="linux" ;;

		# Let it fallback to general "unix" when not using linux exactly
		*)         BUILDTARGET="unix" ;;
	esac

	emake CFLAGS="${CFLAGS}" "${BUILDTARGET}" || die "make failed"
}

src_install() {
	make BIN="${D}/usr/bin" MAN="${D}/usr/share/man/man1" install || die "make install failed"
	dodoc CHANGES README
}
