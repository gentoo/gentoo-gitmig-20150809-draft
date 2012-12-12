# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/freeze/freeze-2.5.0-r1.ebuild,v 1.1 2012/12/12 16:14:01 jer Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Freeze/unfreeze compression program"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/utils/compress/"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"

LICENSE="GPL-1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
	!<=media-libs/mlt-0.4.2
	!media-libs/mlt[melt]
"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	# Hard links confuse prepman and these links are absolute.
	# Fix pre-stripped binary and respect CFLAGS as well
	sed -i -e 's:ln -f:ln -sf:g' \
		-e 's:-strip $@::g' \
		-e '/^CFLAGS/s:=.*:+= -I.:' \
		Makefile.in || die "sed failed"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		OPTIONS="-DDEFFILE=\\\"/etc/freeze.cnf\\\""
}

src_install() {
	dodir /usr/bin /usr/share/man/man1

	emake \
		DEST="${D}/usr/bin" \
		MANDEST="${D}/usr/share/man/man1" \
		install

	# these symlinks collide with app-forensics/sleuthkit (bug #444872)
	rm "${D}"/usr/bin/fcat "${D}"/usr/share/man/man1/fcat.1 || die

	dobin showhuf
	dodoc README *.lsm
}
