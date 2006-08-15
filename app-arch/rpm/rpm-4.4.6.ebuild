# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.4.6.ebuild,v 1.3 2006/08/15 14:01:41 ian Exp $

inherit eutils autotools distutils perl-module

DESCRIPTION="Red Hat Package Management Utils"
HOMEPAGE="http://www.rpm.org/"
SRC_URI="http://wraptastic.org/pub/rpm-4.4.x/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha -amd64 ~arm ~hppa ~ia64 ~mips ~ppc -ppc64 ~s390 ~sh ~sparc x86"
IUSE="nls python perl doc sqlite"
RDEPEND="=sys-libs/db-3.2*
	>=sys-libs/zlib-1.1.3
	>=app-arch/bzip2-1.0.1
	>=dev-libs/popt-1.7
	>=app-crypt/gnupg-1.2
	dev-libs/elfutils
	virtual/libintl
	>=dev-libs/beecrypt-3.1.0-r1
	python? ( >=dev-lang/python-2.2 )
	perl? ( >=dev-lang/perl-5.8.8 )
	nls? ( virtual/libintl )
	sqlite? ( >=dev-db/sqlite-3.3.5 )
	net-misc/neon"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/rpm-4.4.6-with-sqlite.patch

	# the following are additional libraries that might be packaged with
	# the rpm sources. grep for "test -d" in configure.ac
	rm -rf beecrypt elfutils neon popt sqlite zlib intl

	sed -i -e "s:intl ::" Makefile.am
	sed -i -e "s:intl/Makefile ::" configure.ac
	AT_NO_RECURSIVE="yes" eautoreconf
	# TODO Get rid of internal copies of file, lua, db and db3
	# Does not work yet
	#sed -i -e 's/\(\*-\*-linux\*)\tLDFLAGS_STATIC\)="[^"]*"/\1=""/' \
	#	-e "s:WITH_DB_SUBDIR=db3:WITH_DB_SUBDIR=:" \
	#	-e "s:WITH_INTERNAL_DB=1:WITH_INTERNAL_DB=0:" \
	#	configure
}

src_compile() {
	python_version
	econf --enable-posixmutexes \
		--without-javaglue \
		--without-selinux \
		$(use_with python python ${PYVER}) \
		$(use_with doc apidocs) \
		$(use_with perl) \
		$(use_with sqlite) \
		$(use_enable nls) \
		|| die "econf failed"

	emake staticLDFLAGS="" || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	mv ${D}/bin/rpm ${D}/usr/bin
	rmdir ${D}/bin

	use nls || rm -rf ${D}/usr/share/man/??

	keepdir /var/lib/rpm
	keepdir /usr/src/rpm/{SRPMS,SPECS,SOURCES,RPMS/{noarch,i{3,4,5,6}86,athlon},BUILD}

	dodoc CHANGES CREDITS GROUPS README* RPM*
	use doc && dohtml -r apidocs/html/*

	# Fix perllocal.pod file collision
	use perl && fixlocalpod
}

pkg_postinst() {
	if [ -f ${ROOT}/var/lib/rpm/Packages ]; then
		einfo "RPM database found... Rebuilding database (may take a while)..."
		${ROOT}/usr/bin/rpm --rebuilddb --root=${ROOT}
	else
		einfo "No RPM database found... Creating database..."
		${ROOT}/usr/bin/rpm --initdb --root=${ROOT}
	fi

	distutils_pkg_postinst
}
