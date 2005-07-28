# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwnck/libwnck-2.10.3.ebuild,v 1.1 2005/07/28 23:11:11 leonardop Exp $

inherit gnome2

DESCRIPTION="A window navigation construction kit"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc static"

RDEPEND=">=x11-libs/gtk+-2.5.4
	>=dev-libs/glib-2
	>=x11-libs/startup-notification-0.4"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"
USE_DESTDIR="1"
G2CONF="${G2CONF} $(use_enable static)"
