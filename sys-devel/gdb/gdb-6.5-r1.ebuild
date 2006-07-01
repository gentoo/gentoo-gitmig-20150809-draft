# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-6.5-r1.ebuild,v 1.5 2006/07/01 10:39:11 solar Exp $

inherit flag-o-matic eutils

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

#DEB_VER=1
DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="http://ftp.gnu.org/gnu/gdb/${P}.tar.bz2
	ftp://sources.redhat.com/pub/gdb/releases/${P}.tar.bz2
	mirror://gentoo/gdbinit-6.2.txt.bz2"

LICENSE="GPL-2 LGPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"
IUSE="nls test vanilla"

RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND}
	test? ( dev-util/dejagnu )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${WORKDIR}"/gdbinit-6.2.txt . || die

	if ! use vanilla ; then
		if [[ -n ${DEB_VER} ]] ; then
			epatch "${WORKDIR}"/gdb_${PV}-${DEB_VER}.diff
			for f in $(<debian/patches/series) ; do
				EPATCH_SINGLE_MSG="Applying Debian's ${f}" \
				epatch debian/patches/${f}
			done
		fi
		epatch "${FILESDIR}"/gdb-6.4-uclibc.patch
		#epatch "${FILESDIR}"/gdb-6.x-crash.patch
		epatch "${FILESDIR}"/gdb-6.2.1-pass-libdir.patch
		epatch "${FILESDIR}"/gdb-6.5-scanmem.patch
		epatch "${FILESDIR}"/gdb-6.3-gdbinit-stat.patch
	fi

	epatch "${FILESDIR}"/gdb-6.5-locale.patch
	epatch "${FILESDIR}"/gdb-configure-LANG.patch
	strip-linguas -u bfd/po opcodes/po
}

src_compile() {
	replace-flags -O? -O2
	econf \
		--disable-werror \
		$(use_enable nls) \
		|| die
	emake || die
}

src_test() {
	make check || ewarn "tests failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		libdir=/nukeme includedir=/nukeme \
		install || die
	rm -r "${D}"/nukeme || die

	# Don't install docs when building a cross-gdb
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		rm -r "${D}"/usr/share
		return 0
	fi

	dodoc README
	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/README gdb/MAINTAINERS \
		gdb/NEWS gdb/ChangeLog gdb/PROBLEMS
	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING

	if use x86 ; then
		dodir /etc/skel/
		cp "${S}"/gdbinit-6.2.txt "${D}"/etc/skel/.gdbinit \
			|| die "install ${D}/etc/skel/.gdbinit"
	fi

	# Remove shared info pages
	rm -f "${D}"/usr/share/info/{annotate,bfd,configure,standards}.info*
}
