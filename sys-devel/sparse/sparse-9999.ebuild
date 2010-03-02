# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparse/sparse-9999.ebuild,v 1.4 2010/03/02 17:45:26 cardoe Exp $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/devel/sparse/sparse.git"
	GIT_ECLASS="git"
fi

inherit eutils multilib flag-o-matic ${GIT_ECLASS}

DESCRIPTION="C semantic parser"
HOMEPAGE="http://sparse.wiki.kernel.org/index.php/Main_Page"

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://kernel/software/devel/sparse/dist/${P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

LICENSE="OSL-1.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i \
		-e '/^PREFIX=/s:=.*:=/usr:' \
		-e "/^LIBDIR=/s:/lib:/$(get_libdir):" \
		Makefile || die
	append-flags -fno-strict-aliasing
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc FAQ README
}
