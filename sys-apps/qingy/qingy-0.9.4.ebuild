# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qingy/qingy-0.9.4.ebuild,v 1.1 2006/12/21 10:45:00 s4t4n Exp $

inherit eutils

GENTOO_THEME_VERSION="2.0"

DESCRIPTION="a DirectFB getty replacement"
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}-gentoo-theme-${GENTOO_THEME_VERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="crypt directfb emacs gpm logrotate opensslcrypt pam static X"

RDEPEND=">=sys-libs/ncurses-5.4-r6
	opensslcrypt? ( >=dev-libs/openssl-0.9.7e )
	crypt?        ( >=dev-libs/libgcrypt-1.2.1 )
	directfb?     ( >=dev-libs/DirectFB-0.9.24 )
	emacs?        ( virtual/emacs )
	pam?          ( >=sys-libs/pam-0.75-r11 )
	X?            ( || ( (
	                       x11-libs/libX11
	                       x11-libs/libXScrnSaver
	                       x11-proto/scrnsaverproto )
	                       virtual/x11 ) )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=sys-apps/sed-4.1.4-r1"

src_unpack()
{
	if use crypt && use opensslcrypt; then
		echo
		eerror "You can have openssl or libgcrypt as a crypto library, not both."
		eerror "Please check your USE flags..."
		echo
		die "USE flags check failed"
	fi

	if use directfb; then

		#Issues with this version have been work-arounded :-)
		#if has_version "=dev-libs/DirectFB-0.9.25.1"; then
		#	echo
		#	ewarn "You are running DirectFB version 0.9.25.1:"
		#	ewarn "I advise against that as this version introduces"
		#	ewarn "instability, expecially when closing DirectFB mode!"
		#	ewarn "Please consider downgrading DirectFB to version 0.9.24..."
		#	echo
		#	epause
		#fi

		if ! built_with_use -a dev-libs/DirectFB fbcon jpeg png truetype; then
			echo
			eerror "qingy expects DirectFB to provide certain capabilities."
			eerror "It depends on the theme you use, but at least the following USE flags"
			eerror "should be enabled in DirectFB: fbcon jpeg png truetype."
			eerror "You must rebuild DirectFB those USE flags enabled!"
			echo
			die "USE flags check failed"
		fi

	fi

	unpack ${A}
}

src_compile()
{
	local crypto_support="--disable-crypto"

	use opensslcrypt && crypto_support="--enable-crypto=openssl"
	use crypt        && crypto_support="--enable-crypto=libgcrypt"

	econf                                      \
		--sbindir=/sbin                        \
		--disable-optimizations                \
		`use_enable emacs`                     \
		`use_enable pam`                       \
		`use_enable static static-build`       \
		`use_enable gpm gpm-lock`              \
		`use_enable X x-support`               \
		`use_enable directfb DirectFB-support` \
		${crypto_support}                      \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install()
{
	# Copy documentation manually as make install only installs info files
	# INSTALL is left because it contains also configuration informations
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO

	# Install the program
	make DESTDIR=${D} install || die "Installation failed"

	# Set the settings file umask to 600, in case somebody
	# wants to make use of the autologin feature
	/bin/chmod 600 ${D}/etc/qingy/settings

	# Install Gentoo theme
	dodir /usr/share/${PN}/themes/gentoo
	cp ${WORKDIR}/gentoo/* ${D}/usr/share/${PN}/themes/gentoo \
		|| die "Gentoo theme installation failed"

	# Alter config file so that it uses our theme
	sed -i 's/theme = "default"/theme = "gentoo"/' ${D}/etc/${PN}/settings

	# Install log rotation policy if user wants it
	if use logrotate; then
		insinto /etc/logrotate.d
		newins ${FILESDIR}/${PN}-logrotate ${PN} || die "Log rotation policy installation failed"
	fi
}

pkg_postinst()
{
	einfo "In order to use qingy you must first edit your /etc/inittab"
	einfo "Check the documentation at ${HOMEPAGE}"
	einfo "for instructions on how to do that."

	if use crypt; then
		echo
		einfo "You will have to create a key pair using 'qingy-keygen'"
	fi
}
