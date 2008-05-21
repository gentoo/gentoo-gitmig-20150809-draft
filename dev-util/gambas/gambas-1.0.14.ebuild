# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-1.0.14.ebuild,v 1.5 2008/05/21 16:01:49 dev-zero Exp $

inherit eutils qt3

DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net/"
SRC_URI="mirror://sourceforge/gambas/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 -amd64"
IUSE="postgres mysql sdl doc curl sqlite xml xsl zlib kde bzip2"

RDEPEND="$(qt_min_version 3.2)
	kde? ( >=kde-base/kdelibs-3.2 )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer sys-libs/gpm )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	curl? ( net-misc/curl )
	sqlite? ( =dev-db/sqlite-2* )
	xml? ( dev-libs/libxml2 )
	xsl? ( dev-libs/libxslt )
	zlib? ( sys-libs/zlib )
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.59
	>=sys-devel/automake-1.7.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.0.6-configure-CFLAGS.patch

	# replace braindead Makefile (it's getting better, but
	# still has the stupid symlink stuff)
	rm Makefile*
	cp "${FILESDIR}/Makefile.am-1.0_rc2" ./Makefile.am

	aclocal && autoconf && automake || die "autotools failed"
}

src_compile() {
	econf \
		--enable-qt \
		--enable-net \
		--enable-vb \
		$(use_enable mysql) \
		$(use_enable postgres) \
		$(use_enable sqlite) \
		$(use_enable sdl) \
		$(use_enable curl) \
		$(use_enable zlib) \
		$(use_enable xml libxml) \
		$(use_enable xsl xslt) \
		$(use_enable bzip2 bzlib2) \
		$(use_enable kde) \
		--disable-optimization \
		--disable-debug \
		--disable-profiling \
		|| die

	emake || die
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
