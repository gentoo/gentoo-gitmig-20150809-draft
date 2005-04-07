# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/com_err/com_err-1.37.ebuild,v 1.2 2005/04/07 17:38:02 seemant Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="common error display library"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
SRC_URI="mirror://sourceforge/e2fsprogs/e2fsprogs-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/e2fsprogs-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Patch to make the configure and sed scripts more friendly to, 
	# for example, the Estonian locale
	epatch "${FILESDIR}"/${P}-sed-locale.patch
	# Clean up makefile to suck less
	epatch "${FILESDIR}"/${P}-makefile.patch

	# Keep the package from doing silly things
	export LDCONFIG=/bin/true
	export CC=$(tc-getCC)
	export STRIP=/bin/true
}

src_compile() {
	econf \
		--enable-elf-shlibs \
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
