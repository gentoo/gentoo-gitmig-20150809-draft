# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qingy/qingy-0.5.1.ebuild,v 1.1 2004/08/18 11:41:45 s4t4n Exp $

DESCRIPTION="a DirectFB getty replacement"
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="emacs gpm pam static"

DEPEND=">=dev-libs/DirectFB-0.9.18
	emacs? ( virtual/emacs )
	pam?   ( >=sys-libs/pam-0.75-r11 )
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf \
		--sbindir=/sbin \
		--disable-optimizations \
		`use_enable emacs` \
		`use_enable pam` \
		`use_enable static static-build` \
		`use_enable gpm gpm-lock` \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	# copy documentation manually as make install only installs info files
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO

	# and finally install the program
	make DESTDIR=${D} install || die "Installation failed"
}

pkg_postinst() {
	einfo "In order to use qingy you must first edit your /etc/inittab"
	einfo "Check files INSTALL and README in /usr/share/doc/${P}"
	einfo "for instructions on how to do that. Or issue an 'info qingy'."
	echo
	ewarn "Please note that configuration and theme files syntax"
	ewarn "has changed since version 0.2x: please remove all"
	ewarn "old themes and update qingy configuration files!"
	echo
	einfo "Note that since version 0.4x themes are located in"
	einfo "/usr/share/qingy/themes and screensavers in"
	einfo "/usr/lib/qingy/screensavers"
	echo
	einfo "You can safely remove /etc/directfbrc.qingy"
	einfo "as it is no longer needed to get framebuffer resolution"
	echo
	ewarn "Also note that qingy doesn't seem to work realiably with"
	ewarn "2.6.7 kernels due to problems with the DirectFB library."
	ewarn "Your mileage may vary, but it could even lock up your machine!"
	ewarn "See http://bugs.gentoo.org/show_bug.cgi?id=59340"
	ewarn "and http://bugs.gentoo.org/show_bug.cgi?id=60402"
	ewarn "Use either a 2.6.5 or a >=2.6.8 kernel!"
}
