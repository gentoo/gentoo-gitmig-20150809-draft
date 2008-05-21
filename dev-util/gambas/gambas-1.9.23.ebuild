# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-1.9.23.ebuild,v 1.6 2008/05/21 16:01:49 dev-zero Exp $

inherit eutils qt3

MY_P="${PN}2-${PV}"

DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net/"
SRC_URI="mirror://sourceforge/gambas/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 -amd64"
IUSE="postgres mysql sdl doc curl sqlite xml zlib kde bzip2 odbc ldap pdf opengl sqlite3 pcre gtk"

S=${WORKDIR}/${MY_P}

# TODO: add flags for opengl, v4l and corba components
RDEPEND="$(qt_min_version 3.2)
	kde? ( >=kde-base/kdelibs-3.2 )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	curl? ( net-misc/curl )
	sqlite? ( =dev-db/sqlite-2* )
	sqlite3? ( >=dev-db/sqlite-3 )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	zlib? ( sys-libs/zlib )
	bzip2? ( app-arch/bzip2 )
	odbc? ( dev-db/unixODBC )
	ldap? ( net-nds/openldap )
	gtk? ( >=x11-libs/gtk+-2.6.4 )
	pdf? ( app-text/poppler )
	pcre? ( dev-libs/libpcre )"
#DEPEND="${RDEPEND}
#	>=sys-devel/autoconf-2.59
#	>=sys-devel/automake-1.7.5"

#src_unpack() {
#	unpack ${A}
#	cd "${S}"
#	epatch "${FILESDIR}"/${PN}-1.0.6-configure-CFLAGS.patch

	# replace braindead Makefile (it's getting better, but
	# still has the stupid symlink stuff)
#	rm Makefile*
#	cp "${FILESDIR}/Makefile.am-1.0_rc2" ./Makefile.am

#	aclocal && autoconf && automake || die "autotools failed"
#}

src_compile() {

	local ext_conf=""

	# TODO: work opengl deps out first
	#if use opengl; then
	#	ext_conf="${ext_conf} $(use_enable sdl sdlopengl)"
	#	ext_conf="${ext_conf} $(use_enable qt qtopengl)"
	#fi

	econf \
		--enable-qt \
		--enable-net \
		--enable-crypt \
		--enable-vb \
		--disable-corba \
		--disable-opengl \
		--disable-sdlopengl \
		--disable-sdl_opengl \
		--disable-qtopengl \
		--disable-v4l \
		$(use_enable mysql) \
		$(use_enable postgres) \
		$(use_enable sqlite) \
		$(use_enable sqlite3) \
		$(use_enable sdl) \
		$(use_enable curl) \
		$(use_enable zlib) \
		$(use_enable xml) \
		$(use_enable bzip2 bzlib2) \
		$(use_enable kde) \
		$(use_enable gtk) \
		$(use_enable odbc) \
		$(use_enable pdf) \
		$(use_enable pcre) \
		$(use_enable ldap) \
		${ext_conf} \
		--disable-optimization \
		--disable-debug \
		--disable-profiling \
		|| die

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	export PATH="${D}/usr/bin:${PATH}"
	make DESTDIR="${D}" install || die

	dodoc README INSTALL NEWS AUTHORS ChangeLog TODO

	# only install the API docs and examples with USE=doc
	if use doc ; then
		mv "${D}"/usr/share/${PN}/help "${D}"/usr/share/doc/${PF}/html
		mv "${D}"/usr/share/${PN}/examples "${D}"/usr/share/doc/${PF}/examples
	else
		dohtml ${FILESDIR}/WebHome.html
	fi
	rm -r "${D}"/usr/share/${PN}/help "${D}"/usr/share/${PN}/examples
	dosym ../doc/${PF}/html /usr/share/${PN}/help
	dosym ../doc/${PF}/examples /usr/share/${PN}/examples
}
