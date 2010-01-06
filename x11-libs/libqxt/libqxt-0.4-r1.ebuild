# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libqxt/libqxt-0.4-r1.ebuild,v 1.3 2010/01/06 13:03:49 hwoarang Exp $

EAPI=2
inherit eutils qt4-r2

DESCRIPTION="The Qt eXTension library provides cross-platform utility classes for the Qt toolkit"
HOMEPAGE="http://libqxt.org/"
SRC_URI="mirror://sourceforge/libqxt/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="berkdb crypt debug doc sql web"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-script:4
	sql? ( x11-libs/qt-sql:4 )
	berkdb? (
		sys-libs/db
		x11-libs/qt-sql:4
	)
	crypt? (
		>=dev-libs/openssl-0.9.8
		x11-libs/qt-core:4[ssl]
	)
	web? ( >=dev-libs/fcgi-2.4 )"
DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS README LICENSE cpl1.0.txt"

src_configure() {
	local myconf
	myconf="-prefix /usr \
		-libdir /usr/$(get_libdir) \
		-docdir /usr/share/doc/${PF} \
		-qmake-bin /usr/bin/qmake \
		$(use debug && echo -debug) \
		$(use !berkdb && echo -no-db -nomake berkeley) \
		$(use !crypt && echo -nomake crypto -no-openssl) \
		$(use !sql && echo -nomake sql) \
		$(use !web && echo -nomake web)"
	# fix pre-striped files issue
	for i in $(ls "${S}"/src); do
		sed -i "s/qxtbuild/nostrip\ qxtbuild/" "${S}"/src/${i}/${i}.pro
	done
	./configure ${myconf} || die "configure failed"
}

src_compile() {
	# parallel compilation fails, bug #194730
	emake -j1 || die "make failed"
}

src_install() {
	qt4-r2_src_install
	if use doc; then
		doxygen Doqsyfile
		dohtml -r deploy/docs/*
	fi
}
