# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/freeze/freeze-2.5.0.ebuild,v 1.18 2008/05/13 14:01:09 jer Exp $

inherit toolchain-funcs

DESCRIPTION="Freeze/unfreeze compression program"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/utils/compress/"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Hard links confuse prepman and these links are absolute.
	# Fix pre-stripped binary and respect CFLAGS as well
	sed -i -e 's:ln -f:ln -sf:g' \
		-e 's:-strip $@::g' \
		-e '/^CFLAGS/s:=.*:+= -I.:' \
		Makefile.in || die "sed failed"
}

src_compile() {
	econf || die

	emake \
		CC=$(tc-getCC)
		OPTIONS="-DDEFFILE=\\\"/etc/freeze.cnf\\\"" \
		|| die "compile problem"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make install \
		DEST="${D}/usr/bin" \
		MANDEST="${D}/usr/share/man/man1" \
		|| die
	dobin showhuf || die
	dodoc README *.lsm
}
