# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.3.5.ebuild,v 1.17 2012/07/29 18:34:32 armin76 Exp $

inherit flag-o-matic eutils

DESCRIPTION="A set of extensions to TCL"
HOMEPAGE="http://tclx.sourceforge.net"
SRC_URI="mirror://sourceforge/tclx/${PN}${PV}-src.tar.gz
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tcl8.4.6-src.tar.gz
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tk8.4.6-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X"

DEPEND=">=dev-lang/tcl-8.4.6
	X? ( >=dev-lang/tk-8.4.6 )"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${A}

	# Fix bug[s] in configure script #119619
	local d
	for d in */unix/configure ; do
		ebegin "Fixing ${d}"
		while patch ${EPATCH_OPTS} --dry-run ${d} "${FILESDIR}"/${P}-configure.patch > /dev/null ; do
			patch ${d} "${FILESDIR}"/${P}-configure.patch > /dev/null
		done
		eend $?
	done

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-8.3-varinit.patch
	sed -i \
		-e "/^TCLX_INST_MAN/ s:=.*:= \$\{TCLX_PREFIX\}/share/man:" \
		-e "" "${S}"/unix/Common.mk.in \
		|| die "sed Makefile failed"
}

src_compile() {
	# we have to configure and build tcl before we can do tclx
	cd "${WORKDIR}"/tcl8.4.6/unix
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake in tcl/unix failed"

	local myconf="--with-tcl=${WORKDIR}/tcl8.4.6/unix --enable-shared"

	if use X ; then
		# configure and build tk
		cd ${WORKDIR}/tk8.4.6/unix
		econf || die "econf failed"
		emake CFLAGS="${CFLAGS}" || die "make X failed"
		myconf="${myconf} --with-tk=${WORKDIR}/tk8.4.6/unix"
	else
		myconf="${myconf} --enable-tk=no"
	fi

	# configure and build tclx
	cd ${S}/unix
	econf ${myconf} || die "econf failed"
	make CFLAGS="${CFLAGS}" || die "make tclx failed"
}

src_install() {
	cd "${S}"/unix
	make INSTALL_ROOT="${D}" install || die
	cd "${S}"
	dodoc CHANGES README TO-DO doc/CONVERSION-NOTES
	doman doc/*.[n3]
}
