# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-1.0.5.ebuild,v 1.4 2005/07/25 15:42:56 caleb Exp $

inherit eutils qt3

DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net/"
SRC_URI="http://gambas.sourceforge.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE="postgres mysql sdl doc curl debug sqlite xml xsl zlib kde bzip2"

RDEPEND="$(qt_min_version 3.2)
	kde? ( >=kde-base/kdelibs-3.2 )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer sys-libs/gpm )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	curl? ( net-misc/curl )
	sqlite? ( dev-db/sqlite )
	xml? ( dev-libs/libxml2 )
	xsl? ( dev-libs/libxslt )
	zlib? ( sys-libs/zlib )
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-Os::' configure
	# replace braindead Makefile (it's getting better, but 
	# still has the stupid symlink stuff)
	rm Makefile*
	cp "${FILESDIR}/Makefile.am-1.0_rc2" ./Makefile.am

	automake
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
		$(use_enable !debug optimization) \
		$(use_enable debug) \
		$(use_enable debug profiling) \
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
