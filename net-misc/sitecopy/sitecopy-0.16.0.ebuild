# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.16.0.ebuild,v 1.5 2006/02/22 05:03:02 chriswhite Exp $

inherit eutils toolchain-funcs

IUSE="expat gssapi nls rsh ssl webdav xml2 zlib"

DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.lyra.org/sitecopy/"
KEYWORDS="~amd64 ppc sparc x86"
LICENSE="GPL-2"
SLOT="0"
# gnome support is disabled at this point
# as the gnome frontend appears to be
# very unstable! - Chris White
#		gnome? (
#			gnome-base/gnome-libs
#			=x11-libs/gtk+-1* )
DEPEND="rsh? ( net-misc/netkit-rsh )
	>=net-misc/neon-0.24.6"

pkg_setup() {
	ewarn "gnome support has been disabled"
	ewarn "until some major bugs can"
	ewarn "be fixed regarding it!"

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

	if use xml2 ; then
		built_with_use net-misc/neon expat && die "neon needs expat support disabled for
		xml2 support to be enabled"
	fi
}

src_unpack() {
	unpack ${A}
	sed -i -e \
		"s:docdir \= .*:docdir \= \$\(prefix\)\/share/doc\/${PF}:" \
		${S}/Makefile.in || die "Documentation directory patching failed"
}

src_compile() {

	einfo "Sitecopy uses neon unconditionally for a security bug."
	einfo "The sitecopy system also checks for zlib, ssl, and xml"
	einfo "support through neon instead of the actual system libraries"
	einfo "therefore support must be built into neon."

	# Bug 51585, GLSA 200406-03
	einfo "Forcing the use of the system-wide neon library (BR #51585)."
	myconf="${myconf} --with-neon"

	econf ${myconf} \
			$(use_enable webdav) \
			$(use_with gssapi) \
			$(use_enable nls) \
			$(use_enable rsh) \
			$(use_with expat) \
			$(use_with xml2 libxml2 ) \
			|| die "configuration failed"

	#		$(use_with socks) \
	#		$(use_enable gnome gnomefe) \

	# fixes some gnome compile issues
#	if use gnome
#	then
#		echo "int fe_accept_cert(const ne_ssl_certificate *cert, int failures) { return 0; }" >> gnome/gcommon.c
#		sed -i -e "s:-lglib:-lglib -lgthread:" Makefile
#	fi

	emake || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
