# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-1.0_rc2.ebuild,v 1.1 2004/11/14 08:49:54 genone Exp $

inherit eutils

MY_P="${PN}-0.99.RC2"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net"
SRC_URI="http://gambas.sourceforge.net/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="postgres mysql sdl doc curl debug sqlite"

DEPEND=">=sys-devel/automake-1.7.5
	>=x11-libs/qt-3.2
	>=kde-base/kdelibs-3.2
	sdl? ( media-libs/libsdl )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	curl? ( net-misc/curl )
	sqlite? ( dev-db/sqlite )"

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

	myconf="${myconf} --enable-kde --enable-qt"
	myconf="${myconf} `use_enable mysql`"
	myconf="${myconf} `use_enable postgres`"
	myconf="${myconf} `use_enable sqlite`"
	myconf="${myconf} `use_enable sdl`"
	myconf="${myconf} `use_enable curl`"

	if use debug ; then
		myconf="${myconf} --disable-optimization --enable-debug"
	else
		myconf="${myconf} --enable-optimization --disable-debug"
	fi

	econf ${myconf} || die

	emake || die
}

src_install() {
	export PATH="${D}/usr/bin:${PATH}"
	einstall || die

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
