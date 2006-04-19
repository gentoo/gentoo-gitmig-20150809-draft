# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-2.14.2.ebuild,v 1.1 2006/04/19 07:29:15 leonardop Exp $

inherit eutils pam gnome2

DESCRIPTION="GNOME Display Manager"
HOMEPAGE="http://www.gnome.org/projects/gdm/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="accessibility ipv6 pam selinux tcpd xinerama"

# Name of the tarball with gentoo specific files
GDM_EXTRA="${PN}-2.8-gentoo-files-r2"

SRC_URI="${SRC_URI}
	mirror://gentoo/gentoo-gdm-theme-r3.tar.bz2
	mirror://gentoo/${GDM_EXTRA}.tar.bz2"

RDEPEND="pam? ( virtual/pam )
	!pam? ( sys-apps/shadow )
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.6
	>=x11-libs/pango-1.3
	>=gnome-base/libglade-1.109
	>=gnome-base/libgnome-1.96
	>=gnome-base/libgnomeui-1.96
	>=gnome-base/libgnomecanvas-1.109
	>=gnome-base/librsvg-1.1.1
	>=dev-libs/libxml2-2.4.12
	>=media-libs/libart_lgpl-2.3.11
	selinux? ( sys-libs/libselinux )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	|| ( (
			x11-libs/libX11
			x11-libs/libXdmcp
			x11-libs/libXi
			x11-libs/libXext
			x11-libs/libXinerama
			x11-libs/libdmx
			x11-libs/libXau
			x11-apps/sessreg
			accessibility? ( x11-libs/libXevie ) )
		virtual/x11 )
	sys-devel/gettext"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/inputproto
			x11-proto/dmxproto )
		virtual/x11 )
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	>=app-text/scrollkeeper-0.1.4"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"
MAKEOPTS="${MAKEOPTS} -j1"


pkg_setup() {
	G2CONF="--sysconfdir=/etc/X11         \
		--localstatedir=/var              \
		--with-xdmcp                      \
		--with-pam-prefix=/etc            \
		$(use_enable accessibility xevie) \
		$(use_enable ipv6)                \
		$(use_with selinux)               \
		$(use_with tcpd tcp-wrappers)     \
		$(use_with xinerama)"

	if use pam; then
		G2CONF="${G2CONF} --enable-authentication-scheme=pam"
	else
		G2CONF="${G2CONF} --enable-console-helper=no \
			--enable-authentication-scheme=shadow"
	fi

	enewgroup gdm
	enewuser gdm -1 -1 /var/lib/gdm gdm
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove unneeded linker directive for selinux (#41022)
	epatch "${FILESDIR}"/${PN}-2.13.0.1-selinux-remove-attr.patch

	# Fix missing intllib
	epatch "${FILESDIR}"/${PN}-2.13.0.7-gdm-dmx-intllibs.patch

	gnome2_omf_fix docs/*/Makefile.in docs/Makefile.in
}

src_install() {
	gnome2_src_install

	local gentoodir="${WORKDIR}/${GDM_EXTRA}"

	# gdm-binary should be gdm to work with our init (#5598)
	rm -f ${D}/usr/sbin/gdm
	dosym /usr/sbin/gdm-binary /usr/sbin/gdm
	# our x11's scripts point to /usr/bin/gdm
	dosym /usr/sbin/gdm-binary /usr/bin/gdm

	# log, etc.
	keepdir /var/log/gdm
	keepdir /var/gdm
	chown root:gdm ${D}/var/gdm
	chmod 1770 ${D}/var/gdm

	# use our own session script
	rm -f ${D}/etc/X11/gdm/Xsession
	exeinto /etc/X11/gdm
	doexe ${gentoodir}/Xsession

	# add a custom xsession .desktop by default (#44537)
	exeinto /etc/X11/dm/Sessions
	doexe ${gentoodir}/custom.desktop

	# We replace the pam stuff by our own
	rm -rf ${D}/etc/pam.d

	dopamd ${gentoodir}/pam.d/*
	dopamsecurity console.apps ${gentoodir}/security/console.apps/gdmsetup

	# use graphical greeter local
	dosed "s:#Greeter=/usr/libexec/gdmlogin:Greeter=/usr/libexec/gdmgreeter:" \
		/etc/X11/gdm/gdm.conf
	# list available users
	dosed "s:^#MinimalUID=.*:MinimalUID=1000:" /etc/X11/gdm/gdm.conf
	dosed "s:^#IncludeAll=.*:IncludeAll=true:" /etc/X11/gdm/gdm.conf
	# Fix old X11R6 paths
	dosed "s:/usr/X11R6/bin:/usr/bin:" /etc/X11/gdm/gdm.conf

	# Move Gentoo theme in
	mv ${WORKDIR}/gentoo-*  ${D}/usr/share/gdm/themes
}

pkg_postinst() {

	gnome2_pkg_postinst

	# Soft restart, assumes Gentoo defaults for file locations
	FIFOFILE=/var/gdm/.gdmfifo
	PIDFILE=/var/run/gdm.pid
	if [ -w ${FIFOFILE} ] ; then
		if [ -f ${PIDFILE} ] ; then
			if kill -0 `cat ${PIDFILE}`; then
				(echo;echo SOFT_RESTART) >> ${FIFOFILE}
			fi
		fi
	fi

	einfo "To make GDM start at boot, edit /etc/rc.conf"
	einfo "and then execute 'rc-update add xdm default'."

}

pkg_postrm() {
	gnome2_pkg_postrm

	einfo "To remove GDM from startup please execute"
	einfo "'rc-update del xdm default'"
}
