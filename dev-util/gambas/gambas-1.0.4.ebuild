# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-1.0.4.ebuild,v 1.2 2005/04/06 07:40:59 genone Exp $

inherit eutils

DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net"
SRC_URI="http://gambas.sourceforge.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="postgres mysql sdl doc curl debug sqlite xml xsl zlib kde"

DEPEND=">=sys-devel/automake-1.7.5
	>=x11-libs/qt-3.2
	kde? ( >=kde-base/kdelibs-3.2 )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer sys-libs/gpm )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	curl? ( net-misc/curl )
	sqlite? ( dev-db/sqlite )
	xml? ( dev-libs/libxml2 )
	xsl? ( dev-libs/libxslt )
	zlib? ( sys-libs/zlib app-arch/bzip2 )"

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
	local myconf

	myconf="${myconf} --enable-qt  --enable-net --enable-vb"
	myconf="${myconf} `use_enable mysql`"
	myconf="${myconf} `use_enable postgres`"
	myconf="${myconf} `use_enable sqlite`"
	myconf="${myconf} `use_enable sdl`"
	myconf="${myconf} `use_enable curl`"
	myconf="${myconf} `use_enable zlib`"
	myconf="${myconf} `use_enable xml2 libxml`"
	myconf="${myconf} `use_enable xsl xslt`"
	myconf="${myconf} `use_enable zlib bzlib2`"
	myconf="${myconf} `use_enable kde`"

	if use debug ; then
		myconf="${myconf} --disable-optimization --enable-debug --enable-profiling"
	else
		myconf="${myconf} --enable-optimization --disable-debug --disable-profiling"
	fi

	econf ${myconf} || die

	emake || die
}

src_install() {
	export PATH="${D}/usr/bin:${PATH}"
	make DESTDIR="$D" install || die

	dodoc README INSTALL NEWS AUTHORS ChangeLog TODO

	# only install the API docs and examples with USE=doc
	if use doc; then
		mv ${D}/usr/share/${PN}/help ${D}/usr/share/doc/${PF}/html
		mv ${D}/usr/share/${PN}/examples ${D}/usr/share/doc/${PF}/examples
	else
		dohtml ${FILESDIR}/WebHome.html
	fi
	rm -rf ${D}/usr/share/${PN}/help ${D}/usr/share/${PN}/examples
	dosym ../doc/${PF}/html /usr/share/${PN}/help
	dosym ../doc/${PF}/examples /usr/share/${PN}/examples
}
