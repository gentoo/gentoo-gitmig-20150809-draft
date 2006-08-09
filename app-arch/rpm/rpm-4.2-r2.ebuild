# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.2-r2.ebuild,v 1.4 2006/08/09 21:00:39 ranger Exp $

inherit python flag-o-matic libtool eutils

DESCRIPTION="Red Hat Package Management Utils"
HOMEPAGE="http://www.rpm.org/"
SRC_URI="mirror://gentoo/rpm-4.2.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~s390 ~sparc x86"
IUSE="nls python doc"

RDEPEND=">=sys-libs/zlib-1.1.3
	>=app-arch/bzip2-1.0.1
	>=dev-libs/popt-1.7
	>=app-crypt/gnupg-1.2
	dev-libs/elfutils
	!dev-libs/beecrypt
	python? ( >=dev-lang/python-2.2 )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/rpm-4.2-python2.3.diff
	epatch "${FILESDIR}"/rpm-4.2-pic.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch

	# Disable the configue scripts handling of multilib libdirs
	# since econf already sets --libdir correctly
	sed -i -e 's:MARK64=64:MARK64=:' \
		"${S}"/{,file,popt,beecrypt}/configure  || die "sed failed"
	sed -i -e 's:$(libdir)/rpm:$(prefix)/lib/rpm:' \
		"${S}"/Makefile.in || die "sed failed"
}

src_compile() {
	strip-flags
	elibtoolize

	unset LD_ASSUME_KERNEL
	local myconf
	myconf="--enable-posixmutexes --without-javaglue"

	python_version
	use python \
		&& myconf="${myconf} --with-python=${PYVER}" \
		|| myconf="${myconf} --without-python"

	econf ${myconf} `use_enable nls` || die
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	mv "${D}"/bin/rpm "${D}"/usr/bin
	rm -rf "${D}"/bin
	# Fix for bug #8578 (app-arch/rpm create dead symlink)
	# Local RH 7.3 install has no such symlink anywhere
	# ------
	# UPDATE for 4.1!
	# There is a /usr/lib/rpm/rpmpopt-4.1 now
	# the symlink is still created incorrectly. ???
	rm -f "${D}"/usr/lib/rpmpopt
	rm -f "${D}"/usr/$(get_libdir)/libpopt*
	rm -f "${D}"/usr/include/popt.h
	use nls && rm -f  "${D}"/usr/share/locale/*/LC_MESSAGES/popt.mo
	rm -f "${D}"/usr/share/man/man3/popt*

	keepdir /var/lib/rpm
	keepdir /usr/src/pc/{SRPMS,SPECS,SOURCES,RPMS,BUILD}
	keepdir /usr/src/pc/RPMS/{noarch,i{3,4,5,6}86,athlon}
	keepdir /usr/src/pc
	dodoc CHANGES CREDITS GROUPS README* RPM* TODO

	use nls || rm -rf "${D}"/usr/share/man/{ko,ja,fr,pl,ru,sk}

	# create /usr/src/redhat/ and co for rpmbuild
	for d in /usr/src/redhat/{BUILD,RPMS,SOURCES,SPECS,SRPMS}; do
		dodir "${d}"
	done
}

pkg_postinst() {
	if [ -f ${ROOT}/var/lib/rpm/Packages ]; then
		einfo "RPM database found... Rebuilding database (may take a while)..."
		${ROOT}/usr/bin/rpm --rebuilddb --root=${ROOT}
	else
		einfo "No RPM database found... Creating database..."
		${ROOT}/usr/bin/rpm --initdb --root=${ROOT}
	fi

	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/rpmdb
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
