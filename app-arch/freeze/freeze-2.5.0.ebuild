# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/freeze/freeze-2.5.0.ebuild,v 1.3 2004/04/27 21:28:44 max Exp $

DESCRIPTION="Freeze/unfreeze compression program."
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/utils/compress/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Hard links confuse prepman and these links are absolute.
	sed -e "s:ln -f:ln -sf:g" -i Makefile.in || die "sed failed"
}

src_compile() {
	econf

	emake OPTIONS="-DDEFFILE=\\\"/etc/freeze.cnf\\\"" \
		|| die "compile problem"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make install \
		DEST="${D}/usr/bin" \
		MANDEST="${D}/usr/share/man/man1"

	dobin showhuf
	dodoc README *.lsm
}
