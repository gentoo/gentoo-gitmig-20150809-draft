# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/com_err/com_err-1.38.ebuild,v 1.10 2005/08/11 03:25:59 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="common error display library"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
SRC_URI="mirror://sourceforge/e2fsprogs/e2fsprogs-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/e2fsprogs-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.37-makefile.patch
	export LDCONFIG=/bin/true
	export CC=$(tc-getCC)
	export STRIP=/bin/true
}

src_compile() {
	local libtype
	case ${USERLAND} in
		Darwin) libtype=bsd;;
		*)      libtype=elf;;
	esac
	econf \
		--enable-${libtype}-shlibs \
		--with-ldopts="${LDFLAGS}" \
		$(use_enable nls) \
		|| die
	emake -C lib/et || die
}

src_test() {
	make -C lib/et check || die "make check failed"
}

src_install() {
	make -C lib/et DESTDIR="${D}" install || die
	dosed '/^ET_DIR=/s:=.*:=/usr/share/et:' /usr/bin/compile_et
	dosym et/com_err.h /usr/include/com_err.h

	# Move shared libraries to /lib/, install static libraries to /usr/lib/,
	# and install linker scripts to /usr/lib/.
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)/
	dolib.a lib/libcom_err.a || die "dolib.a"
	gen_usr_ldscript libcom_err.so
}

pkg_postinst() {
	echo
	einfo "PLEASE PLEASE take note of this"
	einfo "Please make *sure* to run revdep-rebuild now"
	einfo "Certain things on your system may have linked against a"
	einfo "different version of com_err -- those things need to be"
	einfo "recompiled.  Sorry for the inconvenience"
	echo
	epause 10
	ebeep
}
