# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.7.1.ebuild,v 1.2 2011/01/05 13:14:18 dev-zero Exp $

EAPI=3

inherit autotools eutils

DESCRIPTION="SPICE server and client."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui kde static-libs uri"

RDEPEND=">=app-emulation/spice-protocol-0.7.0
	>=x11-libs/pixman-0.17.7
	media-libs/alsa-lib
	media-libs/celt:0.5.1
	dev-libs/openssl
	>=x11-libs/libXrandr-1.2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXfixes
	virtual/jpeg
	sys-libs/zlib
	gui? ( =dev-games/cegui-0.6* )
	uri? ( dev-libs/uriparser )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

# maintainer notes:
# * opengl support is currently broken

src_prepare() {
	if use uri ; then
		epatch "${FILESDIR}/0001-Added-initial-connection-url-handling-using-the-urip.patch"
		eautoreconf
	fi
}

src_configure() {
	local myconf=""
	use gui && myconf+="--enable-gui "
	econf ${myconf} \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS TODO
	use static-libs || rm "${D}"/usr/lib*/*.la

	if use uri && use kde ; then
		dodir /usr/share/kde4/services
		cat > "${D}/usr/share/kde4/services/spice.protocol" << EOF
[Protocol]
exec=/usr/bin/spicec --uri "%u"
protocol=spice
input=none
output=none
helper=true
listing=
reading=false
writing=false
makedir=false
deleting=false
EOF
	fi
}

pkg_postinst() {
	if use uri ; then
		elog "You enabled uri-handler support in spice. Therefore you"
		elog "might want your browser / deskop environment to handle"
		elog "spice uri's using spicec. To enable this, run:"
		elog "  gconftool-2 -s /desktop/gnome/url-handlers/spice/command '/usr/bin/spicec --uri "%s"' --type String"
		elog "  gconftool-2 -s /desktop/gnome/url-handlers/spice/enabled --type Boolean true"
		if use kde ; then
			elog "For KDE the protocol could be registered automatically."
		fi
	fi
}
