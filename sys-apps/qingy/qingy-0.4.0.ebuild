# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qingy/qingy-0.4.0.ebuild,v 1.3 2004/07/19 19:33:45 malc Exp $

DESCRIPTION="Qingy is a DirectFB getty replacement."
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="emacs pam static"
DEPEND=">=dev-libs/DirectFB-0.9.18
	emacs? ( virtual/emacs )
	pam?   ( >=sys-libs/pam-0.75-r11 )
	>=dev-util/pkgconfig-0.12.0"

src_compile()
{
	# override qingy self-calculated cflags, honour USE flags
	econf MY_CFLAGS="${CFLAGS}"            \
			`use_enable emacs`                 \
			`use_enable pam`                   \
			`use_enable static static-build`   \
			|| die "Configuration failed"

	# if prefix="/" is omitted, after installation qingy
	# will not be able to find its shared libraries
	emake prefix="/" || die "Compilation failed"
}

src_install()
{
	# copy documentation manually as make install only installs info files
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO

	# and finally install the program
	einstall prefix=${D} || die "Installation failed"
}

pkg_postinst()
{
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
	sleep 5
}
