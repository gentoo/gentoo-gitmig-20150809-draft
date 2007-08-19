# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gsm/gsm-1.0.12.ebuild,v 1.1 2007/08/19 09:34:29 drac Exp $

inherit eutils flag-o-matic multilib toolchain-funcs versionator

DESCRIPTION="Lossy speech compression library and tool."
HOMEPAGE="http://kbs.cs.tu-berlin.de/~jutta/toast.html"
SRC_URI="http://www.cs.tu-berlin.de/~jutta/${PN}/${P}.tar.gz"

LICENSE="OSI-Approved"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}"/${PN}-"$(replace_version_separator 2 '-pl' )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-memcpy.patch
	epatch "${FILESDIR}"/${P}-64bit.patch
}

src_compile() {
	# From upstream Makefile. Define this if your host multiplies
	# floats faster than integers, e.g. on a SPARCstation.
	use sparc && append-flags -DUSE_FLOAT_MUL -DFAST

	emake CCFLAGS="${CFLAGS} -c -DNeedFunctionPrototypes=1" \
		CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	dodir /usr/bin /usr/lib /usr/include /usr/share/man/man{1,3}

	emake -j1 INSTALL_ROOT="${D}"/usr \
		GSM_INSTALL_LIB="${D}"/usr/$(get_libdir) \
		GSM_INSTALL_INC="${D}"/usr/include \
		GSM_INSTALL_MAN="${D}"/usr/share/man/man3 \
		TOAST_INSTALL_MAN="${D}"/usr/share/man/man1 \
		install || die "emake install failed."

	dodoc ChangeLog* MACHINES MANIFEST README
}
