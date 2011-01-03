# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/nvclock/nvclock-0.8_p20110102.ebuild,v 1.1 2011/01/03 03:48:31 jer Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk"

RDEPEND="gtk? ( =x11-libs/gtk+-2* )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch
	eautoreconf
}

src_configure() {
	econf --bindir=/usr/bin --disable-qt \
		$(use_enable gtk) $(use_enable gtk nvcontrol)
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install || die
	#dodoc AUTHORS README

	newinitd "${FILESDIR}"/nvclock_initd nvclock
	newconfd "${FILESDIR}"/nvclock_confd nvclock

	#insinto /usr/share/applications
	#doins nvclock.desktop
	#validate_desktop_entries /usr/share/applications/nvclock.desktop
}

pkg_postinst() {
	elog "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	elog "accordingly and then run: rc-update add nvclock default"
}
