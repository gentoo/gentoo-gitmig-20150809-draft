# Copyright 2007-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dwarves/dwarves-1.0_p1.ebuild,v 1.1 2007/06/07 06:50:26 flameeyes Exp $

inherit toolchain-funcs flag-o-matic multilib rpm

MY_P="${P/_p/-}"

DESCRIPTION="pahole and other dwarf debugging tools"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=summary"
SRC_URI="http://oops.ghostprotocols.net:81/acme/dwarves/rpm/SRPMS/${MY_P}.src.rpm"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="dev-libs/elfutils"
DEPEND=">=dev-util/cmake-2.4
	${RDEPEND}"

S="${WORKDIR}"
BUILDDIR="${WORKDIR}/build"

src_compile() {
	mkdir "${BUILDDIR}"
	cd "${BUILDDIR}"

	tc-export CC CXX LD

	use debug || append-flags -DNDEBUG

	cmake \
		-DCMAKE_C_FLAGS_RELEASE="" \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-D__LIB=$(get_libdir) \
		"${S}" \
		|| die "cmake failed"

	emake VERBOSE="1" || die "emake failed"
}

src_install() {
	cd "${BUILDDIR}"

	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	dodir /usr/share/pahole
	mv "${D}/usr/$(get_libdir)/ctracer" \
		"${D}/usr/share/pahole"

	cd "${S}"
	dodoc README README.ctracer
}
