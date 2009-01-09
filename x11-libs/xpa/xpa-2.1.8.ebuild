# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xpa/xpa-2.1.8.ebuild,v 1.5 2009/01/09 22:41:48 josejx Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Messaging system providing communication between programs"
HOMEPAGE="http://hea-www.harvard.edu/RD/xpa"
SRC_URI="http://hea-www.harvard.edu/saord/download/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-ds9-5.4.patch.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
RDEPEND="dev-lang/tcl
	x11-libs/libXt
	!<sci-astronomy/ds9-5.3"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${WORKDIR}"/${P}-ds9-5.4.patch
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed -i -e "s:\${LINK}:\${LINK} ${LDFLAGS}:" mklib
	eautoconf
}

src_configure() {
	econf \
		--enable-shared \
		--enable-threaded-xpans \
		--with-x \
		--with-tcl \
		--with-threads
}

src_compile() {
	emake shlib tclxpa || die "emake failed"
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dosym libtclxpa.so.1.0 /usr/$(get_libdir)/libtclxpa.so
	insinto /usr/$(get_libdir)/tclxpa
	doins pkgIndex.tcl
	mv "${D}"/usr/$(get_libdir)/libtclxpa* "${D}"/usr/$(get_libdir)/tclxpa/

	dodoc README
	if use doc; then
		cd doc
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
		insinto /usr/share/doc/${PF}/html
		doins *.html || die
	fi
}
