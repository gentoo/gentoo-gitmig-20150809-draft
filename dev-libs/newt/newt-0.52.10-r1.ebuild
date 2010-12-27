# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.52.10-r1.ebuild,v 1.9 2010/12/27 22:30:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python toolchain-funcs eutils rpm

DESCRIPTION="Redhat's Newt windowing toolkit development files"
HOMEPAGE="https://fedorahosted.org/newt/"
SRC_URI="https://fedorahosted.org/releases/n/e/newt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="gpm tcl nls"

RDEPEND="=sys-libs/slang-2*
	>=dev-libs/popt-1.6
	elibc_uclibc? ( sys-libs/ncurses )
	gpm? ( sys-libs/gpm )
	tcl? ( =dev-lang/tcl-8.5* )
	"

DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A}
	#rpm_src_unpack
	cd "${S}"

	# bug 73850
	if use elibc_uclibc; then
		sed -i -e 's:-lslang:-lslang -lncurses:g' "${S}"/Makefile.in
	fi

	# bug 212676
	sed -i -e 's:-ltcl8.4:-ltcl8.5:g' "${S}"/Makefile.in

	sed -i -e 's:instroot:DESTDIR:g' "${S}"/Makefile.in || die

	# bug 285854
	epatch "${FILESDIR}"/newt-CVE-2009-2905.patch
}

src_compile() {
	econf \
		$(use_with gpm gpm-support) \
		$(use_with tcl) \
		$(use_enable nls)

	# not parallel safe
	emake -j1 \
		CC="$(tc-getCC)" \
		PYTHONVERS="$(PYTHON)" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install () {
	# the RPM_OPT_FLAGS="ERROR" is there to catch a build error
	# if it fails, that means something in src_compile() didn't build properly
	# not parallel safe
	emake \
		DESTDIR="${D}" \
		prefix="/usr" \
		libdir="/usr/$(get_libdir)" \
		PYTHONVERS="$(PYTHON)" \
		RPM_OPT_FLAGS="ERROR" \
		install || die "make install failed"
	dodoc peanuts.py popcorn.py tutorial.sgml
	doman whiptail.1
}

pkg_postinst() {
	python_mod_optimize snack.py
}

pkg_postrm() {
	python_mod_cleanup snack.py
}
