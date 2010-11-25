# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/qdbm/qdbm-1.8.78.ebuild,v 1.1 2010/11/25 09:51:32 hattya Exp $

EAPI="3"

inherit eutils java-pkg-opt-2 multilib

IUSE="cxx debug java perl ruby zlib"

DESCRIPTION="Quick Database Manager"
HOMEPAGE="http://fallabs.com/qdbm/"
SRC_URI="http://fallabs.com/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
SLOT="0"

RDEPEND="java? ( >=virtual/jre-1.4 )
	perl? ( dev-lang/perl )
	ruby? ( dev-lang/ruby:1.8 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.4 )"

src_prepare() {

	epatch "${FILESDIR}"/${PN}-runpath.diff
	epatch "${FILESDIR}"/${PN}-perl-runpath-vendor.diff

	# apply flags
	sed -i "/^CFLAGS/s/$/ ${CFLAGS}/" Makefile.in || die
	sed -i "/^CXXFLAGS/s/$/ ${CXXFLAGS}/" plus/Makefile.in || die
	sed -i "/^JAVACFLAGS/s/$/ ${JAVACFLAGS}/" java/Makefile.in || die

	# replace make -> $(MAKE)
	sed -i "s/make\( \|$\)/\$(MAKE)\1/g" \
		Makefile.in \
		{cgi,java,perl,plus,ruby}/Makefile.in \
		|| die

}

qdbm_api_for() {

	local u

	for u in cxx java perl ruby; do
		if ! use "${u}"; then
			continue
		fi

		if [ "${u}" = "cxx" ]; then
			u="plus"
		fi

		cd "${u}"
		case "${EBUILD_PHASE}" in
		configure)
			econf || die
			;;
		compile)
			emake || die
			;;
		test)
			emake -j1 check || die
			;;
		install)
			emake \
				DESTDIR="${ED}" \
				MYDATADIR=/usr/share/doc/${P}/html \
				install \
				|| die
		esac
		cd -
	done

}

src_configure() {

	econf \
		$(use_enable debug) \
		$(use_enable zlib) \
		--enable-pthread \
		--enable-iconv \
		|| die
	qdbm_api_for # configure

}

src_compile() {

	emake || die
	qdbm_api_for # compile

}

src_test() {

	emake -j1 check || die
	qdbm_api_for # test

}

src_install() {

	emake DESTDIR="${ED}" install || die

	dodoc ChangeLog NEWS README THANKS
	dohtml -r doc/

	rm -rf "${ED}"/usr/share/${PN}

	qdbm_api_for # install

	if use java; then
		java-pkg_dojar "${ED}"/usr/$(get_libdir)/*.jar
		rm -f "${ED}"/usr/$(get_libdir)/*.jar

	elif use perl; then
		rm -f "${ED}"/$(perl -V:installarchlib | cut -d\' -f2)/*.pod
		find "${ED}" -name .packlist -print0 | xargs -0 rm -f

	fi

	rm -f "${D}"/usr/bin/*test
	rm -f "${D}"/usr/share/man/man1/*test.1*

}
