# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/qdbm/qdbm-1.8.74.ebuild,v 1.10 2007/08/13 20:12:34 dertobi123 Exp $

inherit eutils java-pkg-opt-2 multilib

IUSE="debug java perl ruby zlib"

DESCRIPTION="Quick Database Manager"
HOMEPAGE="http://qdbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="alpha ~amd64 arm ia64 ppc ppc64 s390 sh sparc x86"
SLOT="0"

RDEPEND="java? ( >=virtual/jre-1.4 )
	perl? ( dev-lang/perl )
	ruby? ( virtual/ruby )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.4 )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-runpath.diff
	epatch "${FILESDIR}"/${PN}-perl-runpath-vendor.diff

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
				rm "${D}"/$(perl -V:installarchlib | cut -d\' -f2)/*.pod
				;;
		esac
		cd -
	done

	rm -f "${D}"/usr/bin/*test

}
