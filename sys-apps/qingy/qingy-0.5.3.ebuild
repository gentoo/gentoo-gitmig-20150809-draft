# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qingy/qingy-0.5.3.ebuild,v 1.1 2005/01/11 08:32:08 s4t4n Exp $

DESCRIPTION="a DirectFB getty replacement"
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
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

	# Set the settings file umask to 600, in case somebody
	# wants to make use of the autologin feature
	/bin/chmod 600 ${D}/etc/qingy/settings
}

pkg_postinst() {
	einfo "In order to use qingy you must first edit your /etc/inittab"
	einfo "Check files INSTALL and README in /usr/share/doc/${P}"
	einfo "for instructions on how to do that. Or issue an 'info qingy'."
	echo
	ewarn "Also note that qingy doesn't seem to work realiably with"
	ewarn "2.6.7 kernels due to problems with the DirectFB library."
	ewarn "Your mileage may vary, but it could even lock up your machine!"
	ewarn "See http://bugs.gentoo.org/show_bug.cgi?id=59340"
	ewarn "and http://bugs.gentoo.org/show_bug.cgi?id=60402"
	ewarn "Use either a 2.6.5 or a >=2.6.8 kernel!"
}
