# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwnck/libwnck-2.6.0.1.ebuild,v 1.12 2004/07/04 12:35:36 kloeri Exp $

inherit gnome2 eutils

DESCRIPTION="A window navigation construction kit"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha ~sparc hppa amd64 ~ia64 mips"

RDEPEND=">=x11-libs/gtk+-2.1
	>=x11-libs/startup-notification-0.4
	amd64? ( || ( >=x11-base/xfree-4.3.0-r6 x11-base/xorg-x11 ) )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

src_unpack() {

	unpack ${A}
	cd ${S}
	# Patch for pager issues, see bug #30264
	epatch ${FILESDIR}/${PN}-2.4.0.1-pager.patch

}
