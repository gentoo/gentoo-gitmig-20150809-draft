# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.51.6-r2.ebuild,v 1.3 2007/06/26 01:54:41 mr_bones_ Exp $

inherit python toolchain-funcs eutils flag-o-matic

DESCRIPTION="Redhat's Newt windowing toolkit development files"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~xmerlin/misc/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gpm"

DEPEND="=sys-libs/slang-1*
	>=dev-libs/popt-1.6
	dev-lang/python
	elibc_uclibc? ( sys-libs/ncurses )
	gpm? ( sys-libs/gpm )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/newt-gpm-fix.diff || die
	epatch ${FILESDIR}/newt-0.51.4-fix-wstrlen-for-non-utf8-strings.patch || die
	epatch ${FILESDIR}/${P}-newttextbox-memoryleak.patch || die
	epatch ${FILESDIR}/${P}-assorted-fixes.patch || die
	epatch ${FILESDIR}/${P}-do-not-ignore-EARLY-events-in-listbox--and-allow-textbox-to-take-focus.patch || die

	# bug 73850
	if use elibc_uclibc; then
		sed -i -e 's:-lslang:-lslang -lncurses:g' ${S}/Makefile.in
	fi

	# use the correct compiler...
	sed -i \
		-e 's:gcc:$(CC):g' \
		-e "s:\(libdir =\).*:\1 \$(prefix)/$(get_libdir):g" \
		${S}/Makefile.in || die "sed failed"

	# avoid make cleaning up some intermediate files
	# as it would rebuild them during install :-(
	echo >>${S}/Makefile.in
	echo '$(LIBNEWT): $(LIBOBJS)' >>${S}/Makefile.in
}

src_compile() {
	python_version

	econf \
		$(use_with gpm gpm-support) \
		|| die

	# not parallel safe
	emake -j1 PYTHONVERS="python${PYVER}" RPM_OPT_FLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "make failure"
}

src_install () {
	python_version
	# the RPM_OPT_FLAGS="ERROR" is there to catch a build error
	# if it fails, that means something in src_compile() didn't build properly
	# not parallel safe
	emake -j1 prefix="${D}/usr" PYTHONVERS="python${PYVER}" RPM_OPT_FLAGS="ERROR" install || die "make install failed"
	dodoc CHANGES COPYING peanuts.py popcorn.py tutorial.sgml
	dosym libnewt.so.${PV} /usr/$(get_libdir)/libnewt.so.0.51
}
