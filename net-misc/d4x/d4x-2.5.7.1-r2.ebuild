# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/d4x/d4x-2.5.7.1-r2.ebuild,v 1.2 2007/11/02 18:39:25 drac Exp $

inherit eutils flag-o-matic

DESCRIPTION="GTK based download manager for X."
HOMEPAGE="http://www.krasu.ru/soft/chuchelo"
SRC_URI="http://d4x.krasu.ru/files/${P}.tar.bz2"

KEYWORDS="amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="Artistic"
IUSE="ao esd nls oss ssl"

RDEPEND=">=x11-libs/gtk+-2
	dev-libs/boost
	ssl? ( dev-libs/openssl )
	!ao? ( esd? ( media-sound/esound ) )
	ao? ( media-libs/libao )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext dev-util/intltool )"

pkg_setup() {
	use ao && ewarn "Selecting USE ao will disable oss and esd."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Bugs #111769, #130479 and #193360 plus more.
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	append-flags -D_FILE_OFFSET_BITS=64

	econf $(use_enable nls) \
		$(use_enable esd) \
		$(use_enable oss) \
		$(use_enable ssl openssl) \
		$(use_enable ao libao)

	emake OPTFLAGS="${CXXFLAGS}" || die "emake failed."
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "emake install failed."

	dodoc AUTHORS ChangeLog* NEWS README PLANS TODO
	docinto doc
	dodoc DOC/{FAQ*,README*,THANKS,TROUBLES}
	doman DOC/nt.1

	newicon share/nt.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}
}
