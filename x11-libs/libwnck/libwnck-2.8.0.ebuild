# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwnck/libwnck-2.8.0.ebuild,v 1.1 2004/09/16 15:30:06 foser Exp $

inherit gnome2 eutils

DESCRIPTION="A window navigation construction kit"
HOMEPAGE="http://www.gnome.org/"

IUSE="doc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ~ppc64"

RDEPEND=">=x11-libs/gtk+-2.1
	>=x11-libs/startup-notification-0.4
	amd64? ( || ( x11-base/xorg-x11 >=x11-base/xfree-4.3.0-r6 ) )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
