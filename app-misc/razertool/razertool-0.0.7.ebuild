# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/razertool/razertool-0.0.7.ebuild,v 1.1 2008/08/27 08:44:28 voyageur Exp $

inherit eutils

DESCRIPTION="Unofficial tool for controlling the Razer Copperhead mouse"
HOMEPAGE="http://razertool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk hal"

DEPEND=">=dev-libs/libusb-0.1.12
	hal? ( >=sys-apps/hal-0.5.7 )
	gtk? (
		>=gnome-base/librsvg-2.0
		>=x11-libs/cairo-1.0.0
		>=x11-libs/gtk+-2.8.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i razertool.rules.example \
		-e 's:ACTION=="add", ::' \
		|| die "sed razertool.rules.example action failed"

	if ! use hal ; then
		# plugdev group might not exist (created by hal)
		sed -i razertool.rules.example \
			-e 's:plugdev:root:' \
			|| die "sed razertool.rules.example plugdev failed"
	fi
}

src_compile() {
	econf $(use_enable gtk) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /etc/udev/rules.d
	newins razertool.rules.example 90-razertool.rules \
		|| die "newins failed"

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	if use hal ; then
		elog "To run as non-root, add yourself to the plugdev group:"
		elog "   gpasswd -a <user> plugdev"
	else
		elog "To run as non-root, adapt permissions/owner/group in:"
		elog "   /etc/udev/rules.d/90-razertool.rules"
	fi
	elog "Then unplug and plug in the mouse."
}
