# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gecc/gecc-20021019.ebuild,v 1.3 2002/10/20 00:56:24 lostlogic Exp $

# comprehensive list of any and all USE flags leveraged in the build, 
# with the exception of any ARCH specific flags, i.e. ppc sparc sparc64
# x86 alpha - this is a required variable
IUSE=""
DESCRIPTION="gecc is a tool to speed up compilation of C/C++ sources. It distributes the compilation on a cluster of compilation nodes. It also caches the object files to save some unneeded work."
HOMEPAGE="http://gecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="gpl"
SLOT="0"
KEYWORDS="~x86"
DEPEND="sys-devel/gcc"
RDEPEND="$DEPEND"
S="${WORKDIR}/${P}"

src_compile() {
	rm -rf test
	econf || die "configure failed"
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
	emake || die "make failed"
}

src_install() {
	einstall || die "Install failed"
}
