# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-6.4-r4.ebuild,v 1.2 2006/05/03 14:32:40 flameeyes Exp $

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
	mirror://gentoo/gdb_init.txt.bz2"

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
	mv "${WORKDIR}"/gdb_init.txt . || die

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
		epatch "${FILESDIR}"/gdb-6.4-scanmem.patch
		epatch "${FILESDIR}"/gdb-6.3-gdbinit-stat.patch
		epatch "${FILESDIR}"/bfd-malloc-wrap.patch #91398
		epatch "${FILESDIR}"/gdb-6.3-partial-die-20050503.patch #120091
		epatch "${FILESDIR}"/gdb-6.4-avr-eclipse.patch #126288

		epatch "${FILESDIR}"/gdb-6.2.1-200-uclibc-readline-conf.patch
		epatch "${FILESDIR}"/gdb-6.2.1-400-mips-coredump.patch
		epatch "${FILESDIR}"/gdb-6.2.1-libiberty-pic.patch
	fi

	strip-linguas -u bfd/po opcodes/po
}

src_compile() {
	replace-flags -O? -O2
	econf \
		--disable-werror \
		$(use_enable nls) \
		|| die
	emake -j1 || die
}

src_test() {
	make check || ewarn "tests failed"
}

src_install() {
	make \
		prefix="${D}"/usr \
		mandir="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		libdir="${D}"/nukeme includedir="${D}"/nukeme \
		install || die "install"
	# The includes and libs are in binutils already
	rm -r "${D}"/nukeme

	# Don't install docs when building a cross-gdb
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		rm -r "${D}"/usr/share
		return 0
	fi

	dodoc README
	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/README gdb/MAINTAINERS \
		gdb/NEWS gdb/ChangeLog* gdb/TODO
	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING
	docinto mmalloc
	dodoc mmalloc/MAINTAINERS mmalloc/ChangeLog mmalloc/TODO

	if use x86 ; then
		dodir /etc/skel/
		cp "${S}"/gdb_init.txt "${D}"/etc/skel/.gdbinit \
			|| die "install ${D}/etc/skel/.gdbinit"
	fi

	if ! has noinfo ${FEATURES} ; then
		make \
			infodir="${D}"/usr/share/info \
			install-info \
			|| die "install doc info"
		# Remove shared info pages
		rm -f "${D}"/usr/share/info/{annotate,bfd,configure,standards}.info*
	fi
}
