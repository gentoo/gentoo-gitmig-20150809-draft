# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xdx/xdx-2.4.ebuild,v 1.7 2011/03/29 12:31:59 angelos Exp $

EAPI=1
inherit eutils

DESCRIPTION="a GTK+ TCP/IP DX-cluster and ON4KST chat client."
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/ham"
SRC_URI="http://www.ibiblio.org/pub/linux/apps/ham/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.12:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack(){
	unpack ${A}
	cd "${S}"
	# fix for deprecated macro in GTK+-2.14 and later
	epatch "${FILESDIR}"/xdx-2.4-gtk.patch
	# fix for bug #326627 - deprecated macro in gtk+ from 2.20 on
	if has_version ">=x11-libs/gtk+-2.20" ; then
		epatch "${FILESDIR}"/${PN}-gtk-2.20.patch
	fi
}

src_compile() {
	econf $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}

pkg_postinst() {
	elog "To use the rig control feature, install media-libs/hamlib"
	elog "and enable hamlib in the Preferences dialog. (no need for recompile)"
}
