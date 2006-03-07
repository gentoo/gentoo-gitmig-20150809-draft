# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gsm/gsm-1.0.10.ebuild,v 1.15 2006/03/07 14:50:31 flameeyes Exp $

IUSE=""

inherit eutils versionator toolchain-funcs

S="${WORKDIR}/${PN}-$(replace_version_separator 2 '-pl' )"

DESCRIPTION="Lossy speech compression library and tool."
HOMEPAGE="http://kbs.cs.tu-berlin.de/~jutta/toast.html"
SRC_URI="ftp://ftp.cs.tu-berlin.de/pub/local/kbs/tubmik/gsm/${P}.tar.gz"

SLOT="0"
LICENSE="OSI-Approved"
KEYWORDS="amd64 ppc sparc x86"

src_unpack() {
	unpack ${A}
	cd ${A}
	use amd64 && epatch ${FILESDIR}/${P}-amd64.diff
}

src_compile() {
	emake CC="$(tc-getCC)" CCFLAGS="${CFLAGS} -c -DNeedFunctionPrototypes=1" || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/include /usr/share/man/man{1,3}
	make INSTALL_ROOT="${D}/usr" \
		GSM_INSTALL_INC="${D}/usr/include" \
		GSM_INSTALL_MAN="${D}/usr/share/man/man3" \
		TOAST_INSTALL_MAN="${D}/usr/share/man/man1" \
		install || die

	dodoc COPYRIGHT ChangeLog* MACHINES MANIFEST README
}
