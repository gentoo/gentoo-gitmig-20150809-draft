# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md5deep/md5deep-1.13.ebuild,v 1.1 2007/08/24 09:12:55 nyhm Exp $

inherit toolchain-funcs

DESCRIPTION="Expanded md5sum program with recursive and comparison options"
HOMEPAGE="http://md5deep.sourceforge.net/"
SRC_URI="mirror://sourceforge/md5deep/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CC /s:gcc:$(tc-getCC):" \
		-e "/^CFLAGS /s:-O3:${CFLAGS}:" \
		-e "/^LINK_OPT /s:$: ${LDFLAGS}:" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	case ${CHOST} in
		*-darwin*) BUILDTARGET="mac" ;;
		*-linux*)  BUILDTARGET="linux" ;;
		# Let it fallback to general "unix" when not using linux exactly
		*)         BUILDTARGET="unix" ;;
	esac
	emake "${BUILDTARGET}" || die "emake failed"
}

src_install() {
	emake install \
		BIN="${D}/usr/bin" \
		MAN="${D}/usr/share/man/man1" \
		|| die "emake install failed"
	dodoc CHANGES README
}
