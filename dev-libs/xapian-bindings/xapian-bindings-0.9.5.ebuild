# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian-bindings/xapian-bindings-0.9.5.ebuild,v 1.2 2006/05/28 18:13:54 swegener Exp $

inherit mono eutils autotools

DESCRIPTION="SWIG and JNI bindings for Xapian"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://www.oligarchy.co.uk/xapian/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="python php tcltk mono"

DEPEND="=dev-libs/xapian-${PV}
	python? ( >=dev-lang/python-2.1 )
	php? ( dev-lang/php )
	tcltk? ( >=dev-lang/tcl-8.1 )
	mono? ( >=dev-lang/mono-1.0.8 )"


src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-skip-csharp-test.patch"
	eautoreconf
}

src_compile() {
	econf \
		$(use_with python) \
		$(use_with php) \
		$(use_with tcltk tcl) \
		$(use_with mono csharp) \
		--without-java \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die

	#docs tly et installed under /usr/share/doc/xapian-core,
	# lets move them under /usr/share/doc..
	mv "${D}/usr/share/doc/xapian-bindings" "${D}/usr/share/doc/${PF}"

	dodoc AUTHORS HACKING PLATFORMS README
}
