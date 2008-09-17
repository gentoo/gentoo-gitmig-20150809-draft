# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-lirc-properties/gnome-lirc-properties-0.2.7.ebuild,v 1.1 2008/09/17 22:01:55 cardoe Exp $

DESCRIPTION="GTK+ based utilty to configure LIRC remotes"
HOMEPAGE="https://code.fluendo.com/remotecontrol/trac/
		http://live.gnome.org/gnome-lirc-properties"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="policykit"

RDEPEND=">=app-misc/lirc-0.8.0
		>=dev-lang/python-2.4
		>=sys-auth/policykit-0.7
		>=gnome-extra/policykit-gnome-0.7"
DEPEND=">=dev-util/intltool-0.35.0
		app-text/gnome-doc-utils"

# uses AC_PATH_PROG([lircd]), which is in /usr/sbin which is only in the path
# for root
RESTRICT="userpriv"

src_compile() {
	econf --with-lirc-confdir=/etc $(use_enable policykit policy-kit) || \
		die "econf failed"
	
	emake || die "emake failed"
}
