# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/blt/blt-2.4z-r5.ebuild,v 1.11 2011/10/24 20:25:24 maekke Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_V_SUFFIX="-8.5.2"
HOMEPAGE="
	http://blt.sourceforge.net/
	http://jos.decoster.googlepages.com/bltfortk8.5.2"
SRC_URI="http://jos.decoster.googlepages.com/${PN}${PV}${MY_V_SUFFIX}.tar.gz"
DESCRIPTION="Extension to Tk, adding new widgets, geometry managers, and misc commands"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 arm ~hppa ppc ppc64 sparc x86"

DEPEND="
	dev-lang/tk
	x11-libs/libX11"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}${PV}${MY_V_SUFFIX}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/blt-2.4z-r4-fix-makefile.patch"
	epatch "${FILESDIR}/blt-2.4z-r4-fix-makefile2.patch"
	# From blt-2.4z-6mdk.src.rpm
	epatch "${FILESDIR}"/blt2.4z-64bit.patch

	#epatch "${FILESDIR}"/blt-2.4z-tcl8.5-fix.patch
	epatch "${FILESDIR}"/blt-2.4z-tcl8.5-fixpkgruntime.patch

	# Set the correct libdir
	sed -i -e "s:\(^libdir=\${exec_prefix}/\)lib:\1$(get_libdir):" \
		configure* || die "sed configure* failed"
	sed -i -e "/^scriptdir =/s:lib:$(get_libdir):" \
		Makefile.in demos/Makefile.in || die "sed Makefile.in failed"
}

src_compile() {
	# bug 167934
	append-flags -fPIC

	econf --with-blt=/usr/$(get_libdir)
	# parallel borks
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/bin \
		/usr/$(get_libdir)/blt2.4/demos/bitmaps \
		/usr/share/man/mann \
		/usr/include \
			|| die "dodir failed"
	emake -j1 INSTALL_ROOT="${D}" install || die "make install failed"

	dodoc NEWS PROBLEMS README
	dohtml html/*.html
	for f in `ls "${D}"/usr/share/man/mann` ; do
		mv "${D}"/usr/share/man/mann/${f} "${D}"/usr/share/man/mann/${f/.n/.nblt}
	done

	# bug 259338 - dev-tcltk/blt-2.4z-r4 provides empty pkgIndex.tcl
	cp "${FILESDIR}"/pkgIndex.tcl "${D}"/usr/$(get_libdir)/blt2.4/pkgIndex.tcl
}
