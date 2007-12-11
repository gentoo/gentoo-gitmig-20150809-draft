# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nam/nam-1.11-r1.ebuild,v 1.3 2007/12/11 17:32:51 anant Exp $

inherit eutils versionator

DESCRIPTION="Network Simulator GUI for NS"
HOMEPAGE="http://www.isi.edu/nsnam/nam"
MY_P="${PN}-src-${PV}"
SRC_URI_BASE="http://www.isi.edu/nsnam/dist/"
SRC_URI="${SRC_URI_BASE}/${MY_P}.tar.gz
	${SRC_URI_BASE}/${P}.patch"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-amd64 ~ppc ~sparc ~x86"
IUSE="debug"
DEPEND="x11-libs/libXmu
	>=dev-lang/tcl-8.4.4
	>=dev-lang/tk-8.4.4
	>=dev-tcltk/otcl-1.0.8a
	>=dev-tcltk/tclcl-1.0.13b
	debug? ( dev-tcltk/tcl-debug )"
RDEPEND=">=net-analyzer/ns-2.27
	${DEPEND}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	EPATCH_OPTS="-d ${S} -p0" epatch "${DISTDIR}"/${P}.patch
	# bug 137053
	epatch "${FILESDIR}"/${PN}-1.11-gcc4.patch
}

src_compile() {
	local tclver=$(best_version ">=dev-lang/tcl-8.4.4")
	einfo "Using ${tclver}"
	tclver=$(get_version_component_range 1-3 "${tclver:13}")

	local tkver=$(best_version ">=dev-lang/tk-8.4.4")
	einfo "Using ${tkver}"
	tkver=$(get_version_component_range 1-3 "${tkver:12}")

	econf \
		--mandir=/usr/share/man \
		--enable-release \
		--with-tcl-ver=${tclver} \
		--with-tk-ver=${tkver} \
		$(use_enable debug) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install || die "emake install failed"

	doman nam.1

	dohtml CHANGES.html TODO.html
	dodoc FILES VERSION README
	for i in iecdemos edu ex; do
		docinto ${i}
		dodoc ${i}/*
	done
}
