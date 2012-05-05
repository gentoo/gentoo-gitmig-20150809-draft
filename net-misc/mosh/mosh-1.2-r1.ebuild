# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mosh/mosh-1.2-r1.ebuild,v 1.5 2012/05/05 03:20:43 jdhore Exp $

EAPI=4

inherit autotools eutils linux-info toolchain-funcs

DESCRIPTION="Mobile shell that supports roaming and intelligent local echo"
HOMEPAGE="http://mosh.mit.edu"
SRC_URI="https://github.com/downloads/keithw/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+client examples +server skalibs +utempter"
REQUIRED_USE="|| ( client server )
	examples? ( client )"

RDEPEND="dev-libs/protobuf
	sys-libs/ncurses:5
	virtual/ssh
	client? ( dev-lang/perl
		dev-perl/IO-Tty )
	skalibs? ( dev-libs/skalibs )
	utempter? ( sys-libs/libutempter )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	if ! use skalibs ; then
		if kernel_is -lt 2 6 27 ; then
			ewarn
			ewarn "Consider activating the skalibs USE flag, iff the build fauls"
			ewarn
		fi
	fi
}

src_prepare() {
	einfo remove bundled skalibs
	rm -r third || die
	if use skalibs ; then
		epatch "${FILESDIR}"/${P}-shared-skalibs.patch
		eautoreconf
		epatch "${FILESDIR}"/${P}-shared-skalibs-fix-configure.patch
	else
		epatch "${FILESDIR}"/${PF}-remove-skalibs.patch
		eautoreconf
	fi
}

src_configure() {
	local my_args=""
	if use skalibs ; then
		my_args=" --with-skalibs="${EPREFIX}
		my_args+=" --with-skalibs-include="${EPREFIX}/usr/include/skalibs
		my_args+=" --with-skalibs-libdir="${EPREFIX}/usr/$(get_libdir)/skalibs
	fi
	econf ${my_args} \
		$(use_enable client) \
		$(use_enable server) \
		$(use_enable examples) \
		$(use_with utempter)
}

src_compile() {
	emake V=1
}

src_install() {
	default

	for myprog in $(find src/examples -type f -perm /0111) ; do
		newbin ${myprog} ${PN}-$(basename ${myprog})
		elog "${myprog} installed as ${PN}-$(basename ${myprog})"
	done
}
