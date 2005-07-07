# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwnck/libwnck-2.8.1-r1.ebuild,v 1.10 2005/07/07 03:38:50 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="A window navigation construction kit"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.1
	>=x11-libs/startup-notification-0.4"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {

	unpack ${A}
	# Apply the patch to show all monitor's applications
	# if there is only one tasklist. see bug #70235
	epatch ${FILESDIR}/${PN}-2.8-multimon-tasklist.patch

}
