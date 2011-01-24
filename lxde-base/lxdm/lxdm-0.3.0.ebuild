# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxdm/lxdm-0.3.0.ebuild,v 1.1 2011/01/24 19:08:19 lxnay Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="LXDE Display Manager"
HOMEPAGE="http://lxde.org"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+consolekit nls"

RDEPEND="sys-libs/pam
	x11-libs/gtk+:2
	consolekit? ( sys-auth/consolekit )
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig"

src_configure() {
	econf --with-x $(use_enable nls) || die "econf failed"
}

src_prepare() {
	# There is consolekit
	epatch "${FILESDIR}/${P}-pam_console-disable.patch"
	use consolekit || epatch "${FILESDIR}/${P}-consolekit-disable.patch"

	# this replaces the bootstrap/autogen script in most packages
	eautoreconf

	# process LINGUAS
	if use nls; then
		einfo "Running intltoolize ..."
		intltoolize --force --copy --automake || die
		strip-linguas -i "${S}/po" || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README TODO || die
}

pkg_postinst() {
	echo
	elog "LXDM in the early stages of development!"
	echo
}
