# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.0.11_rc2.ebuild,v 1.3 2012/03/13 18:38:10 ssuominen Exp $

EAPI=4

MY_P=${P/_/-}

inherit libtool multilib toolchain-funcs eutils

DESCRIPTION="a portable, high level programming interface to various calling conventions."
HOMEPAGE="http://sourceware.org/libffi/"
SRC_URI="ftp://sourceware.org/pub/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="debug static-libs test"

RDEPEND=""
DEPEND="test? ( dev-util/dejagnu )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	# Detect and document broken installation of sys-devel/gcc in the build.log wrt #354903
	if ! has_version ${CATEGORY}/${PN}; then
		local base="${T}/conftest"
		echo 'int main() { }' > "${base}.c"
		$(tc-getCC) -o "${base}" "${base}.c" -lffi >&/dev/null && \
			ewarn "Found a copy of second ${PN} in your system. Uninstall it before continuing."
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-3.0.9-x32.patch \
		"${FILESDIR}"/${P}-fix-ppc64-compile.patch
	elibtoolize
}

src_configure() {
	use userland_BSD && export HOST="${CHOST}"
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog* README
	rm -f "${ED}"usr/lib*/${PN}.la
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/${PN}$(get_libname 5)
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/${PN}$(get_libname 5)
}
