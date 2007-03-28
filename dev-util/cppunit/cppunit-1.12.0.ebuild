# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.12.0.ebuild,v 1.1 2007/03/28 21:30:06 dev-zero Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=1.9

inherit eutils autotools qt3

DESCRIPTION="C++ port of the famous JUnit framework for unit testing"
HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples qt3"

RDEPEND="qt3? ( $(qt_min_version 3.3) )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen
	media-gfx/graphviz )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-1.10.2-asneeded.patch"
	epatch "${FILESDIR}/${P}-add_missing_include.patch"

	AT_M4DIR="${S}/config"
	eautomake
	elibtoolize
}

src_compile() {
	econf \
		$(use_enable doc doxygen) \
		$(use_enable doc dot) \
		--htmldir=/usr/share/doc/${PF}/html \
		|| die "econf failed"
	emake || die "emake failed"

	if use qt3 ; then
		cd src/qttestrunner
		qmake qttestrunnerlib.pro || die "qmake failed"
		emake || die "emake failed"
		if use examples ; then
			cd "${S}/examples/qt"
			qmake qt_example.pro || die "qmake failed"
			emake || die "emake failed"
		fi
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS NEWS README THANKS TODO doc/FAQ

	if use qt3 ; then
		dolib lib/*
	fi

	if use examples ; then
		insinto /usr/share/${PN}
		doins -r examples
	fi
}
