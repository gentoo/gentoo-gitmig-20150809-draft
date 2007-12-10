# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/blt/blt-2.4z-r2.ebuild,v 1.3 2007/12/10 17:33:57 tgall Exp $

inherit eutils flag-o-matic toolchain-funcs

HOMEPAGE="http://blt.sourceforge.net/"
SRC_URI="mirror://sourceforge/blt/BLT2.4z.tar.gz"
DESCRIPTION="BLT is an extension to the Tk toolkit adding new widgets, geometry managers, and miscellaneous commands."

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=dev-lang/tk-8.0
	x11-libs/libX11"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/blt2.4z-install.diff
	# From blt-2.4z-6mdk.src.rpm
	epatch "${FILESDIR}"/blt2.4z-64bit.patch

	# Set the correct libdir
	sed -i -e "s:\(^libdir=\${exec_prefix}/\)lib:\1$(get_libdir):" \
		configure* || die "sed configure* failed"
	sed -i -e "/^scriptdir =/s:lib:$(get_libdir):" \
		Makefile.in demos/Makefile.in || die "sed Makefile.in failed"
}

src_compile() {
	tc-export CC CFLAGS

	# bug 167934
	append-flags -fPIC

	econf --with-blt=/usr/$(get_libdir) || die "./configure failed"
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
}
