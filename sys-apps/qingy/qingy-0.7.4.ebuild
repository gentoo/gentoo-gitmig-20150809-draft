# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qingy/qingy-0.7.4.ebuild,v 1.4 2006/08/24 07:23:40 s4t4n Exp $

DESCRIPTION="a DirectFB getty replacement"
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="crypto_openssl crypto_libgcrypt emacs gpm pam static"

RDEPEND=">=dev-libs/DirectFB-0.9.18
	crypto_openssl?   ( >=dev-libs/openssl-0.9.7e )
	crypto_libgcrypt? ( >=dev-libs/libgcrypt-1.2.1 )
	emacs?            ( virtual/emacs )
	pam?              ( >=sys-libs/pam-0.75-r11 )
	>=sys-libs/ncurses-5.4-r6
	|| ( (
		x11-libs/libX11
		x11-libs/libXScrnSaver )
	virtual/x11 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_unpack()
{
	if use crypto_openssl && use crypto_libgcrypt; then
		echo
		eerror "You can have openssl or libgcrypt as a crypto library, not both."
		eerror "Please check your USE flags..."
		echo
		die "USE flags check failed"
	fi

	unpack ${A}
}

src_compile()
{
	local crypto_support="--disable-crypto"

	use crypto_openssl   && crypto_support="--enable-crypto=openssl"
	use crypto_libgcrypt && crypto_support="--enable-crypto=libgcrypt"

	econf                                \
		--sbindir=/sbin                  \
		--disable-optimizations          \
		`use_enable emacs`               \
		`use_enable pam`                 \
		`use_enable static static-build` \
		`use_enable gpm gpm-lock`        \
		${crypto_support}                \
	|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install()
{
	# copy documentation manually as make install only installs info files
	# INSTALL is left because it contains also configuration informations
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO

	# and finally install the program
	make DESTDIR=${D} install || die "Installation failed"

	# Set the settings file umask to 600, in case somebody
	# wants to make use of the autologin feature
	/bin/chmod 600 ${D}/etc/qingy/settings
}

pkg_postinst()
{
	einfo "In order to use qingy you must first edit your /etc/inittab"
	einfo "Check the documentation at ${HOMEPAGE}"
	einfo "for instructions on how to do that."
	echo
	ewarn "Also note that qingy doesn't seem to work realiably with"
	ewarn "2.6.7 kernels due to problems with the DirectFB library."
	ewarn "Your mileage may vary, but it could even lock up your machine!"
	ewarn "See http://bugs.gentoo.org/show_bug.cgi?id=59340"
	ewarn "and http://bugs.gentoo.org/show_bug.cgi?id=60402"
	ewarn "Use either a 2.6.5 or a >=2.6.8 kernel!"

	if use crypto_libgcrypt; then
		echo
		einfo "You will have to create a key pair using 'qingy-keygen'"
	fi
}
