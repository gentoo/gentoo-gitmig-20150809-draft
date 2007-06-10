# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rawrec/rawrec-0.9.991.ebuild,v 1.1 2007/06/10 13:28:51 drac Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="CLI program to play and record audiofiles."
HOMEPAGE="http://rawrec.sourceforge.net"
SRC_URI="mirror://sourceforge/rawrec/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

S="${S}"/src

src_compile() {
	append-ldflags -lm -lpthread
	emake CC="$(tc-getCC)" OPTFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	emake EXE_DIR=${D}/usr/bin \
		MAN_DIR=${D}/usr/share/man/man1 install || die "emake install failed."

	einfo "Removing SUID from binary.."
	fperms 755 /usr/bin/rawrec
}
