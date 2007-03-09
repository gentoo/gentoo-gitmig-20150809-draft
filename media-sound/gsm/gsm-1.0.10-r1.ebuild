# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gsm/gsm-1.0.10-r1.ebuild,v 1.1 2007/03/09 03:17:53 beandog Exp $

IUSE=""

inherit eutils versionator toolchain-funcs

S="${WORKDIR}/${PN}-$(replace_version_separator 2 '-pl' )"
DESCRIPTION="Lossy speech compression library and tool."
HOMEPAGE="http://kbs.cs.tu-berlin.de/~jutta/toast.html"
SRC_URI="ftp://ftp.cs.tu-berlin.de/pub/local/kbs/tubmik/gsm/${P}.tar.gz"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="OSI-Approved"

src_unpack() {
	unpack ${A}
	cd ${S}
	use amd64 && epatch ${FILESDIR}/${P}-amd64.diff
}

src_compile() {
	emake CC="$(tc-getCC)" WAV49="-DWAV49" CCFLAGS="${CFLAGS} -c -DNeedFunctionPrototypes=1" || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/include /usr/share/man/man{1,3}
	make INSTALL_ROOT="${D}/usr" \
		GSM_INSTALL_INC="${D}/usr/include" \
		GSM_INSTALL_MAN="${D}/usr/share/man/man3" \
		TOAST_INSTALL_MAN="${D}/usr/share/man/man1" \
		install || die

	dodoc ChangeLog* MACHINES MANIFEST README
}
