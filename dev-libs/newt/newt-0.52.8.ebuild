# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.52.8.ebuild,v 1.1 2008/03/17 15:40:30 xmerlin Exp $

inherit python toolchain-funcs eutils rpm

DESCRIPTION="Redhat's Newt windowing toolkit development files"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~xmerlin/misc/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gpm tcl nls"

RDEPEND="=sys-libs/slang-2*
	>=dev-libs/popt-1.6
	dev-lang/python
	elibc_uclibc? ( sys-libs/ncurses )
	gpm? ( sys-libs/gpm )
	tcl? ( =dev-lang/tcl-8.4* )
	"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	#rpm_src_unpack
	cd "${S}"

	if ! use tcl; then
		epatch "${FILESDIR}"/${PN}-0.52.7-notcl.patch || die
	fi

	# bug 73850
	if use elibc_uclibc; then
		sed -i -e 's:-lslang:-lslang -lncurses:g' "${S}"/Makefile.in
	fi

	sed -i -e 's:instroot:DESTDIR:g' "${S}"/Makefile.in || die
}

src_compile() {
	python_version

	econf \
		$(use_with gpm gpm-support) \
		$(use_enable nls)

	# not parallel safe
	emake -j1 \
		CC="$(tc-getCC)" \
		PYTHONVERS="python${PYVER}" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install () {
	python_version
	# the RPM_OPT_FLAGS="ERROR" is there to catch a build error
	# if it fails, that means something in src_compile() didn't build properly
	# not parallel safe
	emake \
		DESTDIR="${D}" \
		prefix="/usr" \
		libdir="/usr/$(get_libdir)" \
		PYTHONVERS="python${PYVER}" \
		RPM_OPT_FLAGS="ERROR" \
		install || die "make install failed"
	dodoc peanuts.py popcorn.py tutorial.sgml
	doman whiptail.1

}
