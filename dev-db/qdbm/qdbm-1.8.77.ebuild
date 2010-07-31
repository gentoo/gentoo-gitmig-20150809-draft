# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/qdbm/qdbm-1.8.77.ebuild,v 1.11 2010/07/31 10:28:55 hattya Exp $

inherit eutils java-pkg-opt-2 multilib

IUSE="debug java perl ruby zlib"

DESCRIPTION="Quick Database Manager"
HOMEPAGE="http://qdbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
SLOT="0"

RDEPEND="java? ( >=virtual/jre-1.4 )
	perl? ( dev-lang/perl )
	ruby? ( dev-lang/ruby )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.4 )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-runpath.diff
	epatch "${FILESDIR}"/${PN}-perl-runpath-vendor.diff

	sed -i "/^CFLAGS/s/$/ ${CFLAGS}/" Makefile.in || die
	sed -i "/^JAVACFLAGS/s/$/ ${JAVACFLAGS}/" java/Makefile.in || die

	# replace make -> $(MAKE)
	sed -i "s/make\( \|$\)/\$(MAKE)\1/g" \
		Makefile.in \
		{cgi,java,perl,plus,ruby}/Makefile.in \
		|| die

}

src_compile() {

	econf \
		$(use_enable debug) \
		$(use_enable zlib) \
		--enable-pthread \
		--enable-iconv \
		|| die
	emake || die

	local u

	for u in java perl ruby; do
		if ! use ${u}; then
			continue
		fi

		cd ${u}
		econf || die
		emake || die
		cd -
	done

}

src_test() {

	emake -j1 check || die

	local u

	for u in java perl ruby; do
		if ! use ${u}; then
			continue
		fi

		cd ${u}
		emake -j1 check || die
		cd -
	done

}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc ChangeLog NEWS README THANKS
	dohtml *.html

	rm -rf "${D}"/usr/share/${PN}

	local u mydatadir=/usr/share/doc/${P}/html

	for u in java perl ruby; do
		if ! use ${u}; then
			continue
		fi

		cd ${u}
		emake DESTDIR="${D}" MYDATADIR=${mydatadir}/${u} install || die

		case ${u} in
			java)
				java-pkg_dojar "${D}"/usr/$(get_libdir)/*.jar
				rm -f "${D}"/usr/$(get_libdir)/*.jar
				;;
			perl)
				rm -f "${D}"/$(perl -V:installarchlib | cut -d\' -f2)/*.pod
				find "${D}" -name .packlist -print0 | xargs -0 rm -f
				;;
		esac
		cd -
	done

	rm -f "${D}"/usr/bin/*test

}
