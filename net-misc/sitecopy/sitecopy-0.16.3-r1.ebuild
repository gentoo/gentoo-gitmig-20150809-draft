# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.16.3-r1.ebuild,v 1.1 2008/01/26 16:47:19 armin76 Exp $

inherit eutils autotools

IUSE="expat nls rsh ssl webdav xml zlib"

DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.lyra.org/sitecopy/"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND="rsh? ( net-misc/netkit-rsh )
	>=net-misc/neon-0.24.6"

pkg_setup() {
	if use zlib ; then
		built_with_use net-misc/neon zlib || die "neon needs zlib support"
	fi

	if use ssl ; then
		built_with_use net-misc/neon ssl || die "neon needs ssl support"
		myconf="${myconf} --with-ssl=openssl"
	fi

	if use expat ; then
		built_with_use net-misc/neon expat || die "neon needs expat support"
	fi

	if use xml ; then
		built_with_use net-misc/neon expat && die "neon needs expat support disabled for
		libxml2 support to be enabled"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Debian patches
	epatch "${FILESDIR}"/*.dpatch

	sed -i -e \
		"s:docdir \= .*:docdir \= \$\(prefix\)\/share/doc\/${PF}:" \
		Makefile.in || die "Documentation directory patching failed"

	eautoconf
	eautomake
}

src_compile() {
	econf ${myconf} \
			$(use_enable webdav) \
			$(use_enable nls) \
			$(use_enable rsh) \
			$(use_with expat) \
			$(use_with xml libxml2 ) \
			--with-neon \
			|| die "econf failed"

	emake || die "eake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
