# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sabayon/sabayon-2.18.0.ebuild,v 1.1 2007/03/27 17:21:04 dang Exp $

inherit gnome2 eutils python multilib

DESCRIPTION="Tool to maintain user profiles in a GNOME desktop"
HOMEPAGE="http://www.gnome.org/projects/sabayon/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# Unfortunately the configure.ac is wildly insufficient, so dependencies have
# to be got from the RPM .spec file...
DEPEND="dev-lang/python
	>=x11-libs/gtk+-2.6.0
	>=dev-python/pygtk-2.5.3
	x11-libs/pango
	dev-python/python-ldap
	x11-base/xorg-server"

RDEPEND="${DEPEND}
	virtual/pam
	app-admin/gamin
	dev-libs/libxml2
	>=gnome-base/gconf-2.8.1
	>=dev-python/gnome-python-2.6.0"

pkg_setup() {
	if built_with_use x11-base/xorg-server minimal; then
		eerror "${PN} needs Xnest, which the minimal USE flag disables."
		eerror "Please re-emerge x11-base/xorg-xserver with USE=-minimal"
		die "need x11-base/xorg-xserver built without minimal USE flag"
	fi
	if ! built_with_use dev-libs/libxml2 python; then
		eerror "${PN} needs the python bindings to libxml2."
		eerror "Please re-emerge dev-libs/libxml2 with USE=python"
		die "need dev-libs/libxml2 built with python USE flag"
	fi
	# dang: I don't think this should happen...  Python is a system dep
	if ! python_mod_exists gamin; then
		# app-admin/gamin (0.1.7, at least) lacks "python" USE flag even though
		# it builds python bindings. That's not good, hackers. That's not good.
		eerror "${PN} needs the python bindings to gamin. Please re-emerge"
		eerror "app-admin/gamin, and ensure the python bindings are built."
		die "need python bindings to app-admin/gamin"
	fi

	G2CONF="--with-distro=gentoo \
		--with-prototype-user=${PN}-admin \
		--enable-console-helper=no \
		--with-pam-prefix=/lib/security"

	einfo "Adding user '${PN}-admin' as the prototype user"
	# I think /var/lib/sabayon is the correct directory to use here.
	enewgroup ${PN}-admin
	enewuser ${PN}-admin -1 -1 "/var/lib/sabayon" "${PN}-admin"
	# Should we delete the user/group on unmerge?

	DOCS="AUTHORS ChangeLog ISSUES NEWS README TODO"
	USE_DESTDIR="1"
}

pkg_postinst() {
	# unfortunately /etc/gconf is CONFIG_PROTECT_MASK'd
	elog "To apply Sabayon defaults and mandatory settings to all users, put"
	elog '    include "$(HOME)/.gconf.path.mandatory"'
	elog "in /etc/gconf/2/local-mandatory.path and put"
	elog '    include "$(HOME)/.gconf.path.defaults"'
	elog "in /etc/gconf/2/local-defaults.path."
	elog "You can safely create these files if they do not already exist."
}
