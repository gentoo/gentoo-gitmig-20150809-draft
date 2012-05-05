# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/lightdm-1.1.9.ebuild,v 1.3 2012/05/05 04:53:53 jdhore Exp $

EAPI=4
inherit autotools eutils pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/LightDM"
SRC_URI="http://launchpad.net/${PN}/1.2/${PV}/+download/${P}.tar.gz
	mirror://gentoo/introspection-20110205.m4.tar.bz2"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

RDEPEND="dev-libs/glib:2
	virtual/pam
	x11-libs/libxklavier
	x11-libs/libX11
	dev-libs/libxml2
	introspection? ( dev-libs/gobject-introspection )
	sys-apps/accountsservice"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	gnome-base/gnome-common
	sys-devel/gettext
	dev-util/gtk-doc-am"
PDEPEND="x11-misc/lightdm-gtk-greeter"

DOCS=( NEWS )

src_prepare() {
	sed -i -e "/minimum-uid/s:500:1000:" data/users.conf || die
	sed -i -e "s:gtk+-3.0:gtk+-2.0:" configure.ac || die
	epatch "${FILESDIR}"/session-wrapper-${PN}.patch
	if has_version dev-libs/gobject-introspection; then
		eautoreconf
	else
		AT_M4DIR=${WORKDIR} eautoreconf
	fi
}

src_configure() {
	# Maybe in the future, we can support some automatic session and user
	# recognition. Until then, use default values
	local default=gnome user=root greeter

	# There is no qt greeter, so use gtk anyway
	# use gtk && greeter=lightdm-gtk-greeter
	greeter=lightdm-gtk-greeter

	# Let user know how lightdm is configured
	einfo "Gentoo configuration"
	einfo "Default greeter: ${greeter}"
	einfo "Default session: ${default}"
	einfo "Greeter user: ${user}"

	# do the actual configuration
	econf --localstatedir=/var \
		--disable-static \
		$(use_enable introspection) \
		--disable-liblightdm-qt \
		--with-user-session=${user} \
		--with-greeter-session=${greeter} \
		--with-greeter-user=${user} \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
}

src_install() {
	default

	# Install missing files
	insinto /etc/${PN}/
	doins "${S}"/data/{${PN},users,keys}.conf
	doins "${FILESDIR}"/Xsession
	fperms +x /etc/${PN}/Xsession
	# remove .la files
	find "${ED}" -name "*.la" -exec rm -rf {} +
	rm -Rf "${ED}"/etc/init || die

	dopamd "${FILESDIR}"/${PN}
	dopamd "${FILESDIR}"/${PN}-autologin
}

pkg_postinst() {
	elog
	elog "Even though the default /etc/${PN}/${PN}.conf will work for"
	elog "most users, make sure you configure it to suit your needs"
	elog "before using ${PN} for the first time."
	elog "You can test the configuration file using the following"
	elog "command: ${PN} --test-mode -c /etc/${PN}/${PN}.conf. This"
	elog "requires xorg-server to be built with the 'kdrive' useflag."
	elog
}
