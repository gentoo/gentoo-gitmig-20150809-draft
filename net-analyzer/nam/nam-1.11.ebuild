# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nam/nam-1.11.ebuild,v 1.1 2005/02/27 05:12:09 robbat2 Exp $

inherit eutils

DESCRIPTION="Network Simulator GUI for NS"
HOMEPAGE="http://www.isi.edu/nsnam/${PN}/"
MY_P="${PN}-src-${PV}"
SRC_URI_BASE="http://www.isi.edu/nsnam/dist/"
SRC_URI="${SRC_URI_BASE}/${MY_P}.tar.gz
		${SRC_URI_BASE}/${P}.patch"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="debug"
need_tclver="8.4.4"
valid_tclver="${need_tclver}"
mytclver=""
DEPEND="virtual/x11
		>=dev-lang/tcl-${need_tclver}
		>=dev-lang/tk-${need_tclver}
		>=dev-tcltk/otcl-1.0.8a
		>=dev-tcltk/tclcl-1.0.13b
		dev-tcltk/tcl-debug"
RDEPEND=">=net-analyzer/ns-2.27
		 ${DEPEND}"

findtclver() {
	# input should always be in INCREASING order
	local ACCEPTVER="8.3 8.4"
	[ -n "$*" ] && ACCEPTVER="$*"
	for i in ${ACCEPTVER}; do
		use debug && einfo "Testing TCL ${i}"
		# we support being more specific
		[ "$(#i)" = "3" ] && i="${i}*"
		has_version ">=dev-lang/tcl-${i}" && mytclver=${i}
	done
	use debug && einfo "Using TCL ${mytclver}"
	if [ -z "${mytclver}" ]; then
		die "Unable to find a suitable version of TCL"
	fi
}

src_unpack() {
	unpack ${MY_P}.tar.gz
	EPATCH_OPTS="-d ${S} -p0" epatch ${DISTDIR}/${P}.patch
}

src_compile() {
	local myconf
	findtclver ${valid_tclver}
	myconf="${myconf} --with-tcl-ver=${mytclver} --with-tk-ver=${mytclver}"

	econf ${myconf} \
	--mandir=/usr/share/man \
	--enable-stl \
	--enable-release \
	|| die "./configure failed"
	emake || die
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install || die
	doman nam.1
	dohtml CHANGES.html TODO.html
	dodoc FILES VERSION INSTALL.WIN32 README
	docinto iecdemos ; dodoc iecdemos/*
	docinto edu ; dodoc edu/*
	docinto examples ; dodoc ex/*
}
