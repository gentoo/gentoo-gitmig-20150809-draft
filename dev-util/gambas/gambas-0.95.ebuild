# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-0.95.ebuild,v 1.1 2004/07/19 22:02:04 genone Exp $

inherit eutils

DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net"
SRC_URI="http://gambas.sourceforge.net/${P}.tar.bz2"

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
	curl? ( net-misc/curl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-Os::' configure
	# replace braindead Makefile
	rm Makefile*
	cp "${FILESDIR}/Makefile.am-0.94" ./Makefile.am
	# patches against hardcoded paths
	epatch ${FILESDIR}/non-symlink-0.95.patch

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
	dosym /usr/share/doc/${PF}/html /usr/share/${PN}/help
	dosym /usr/share/doc/${PF}/examples /usr/share/${PN}/examples
}
