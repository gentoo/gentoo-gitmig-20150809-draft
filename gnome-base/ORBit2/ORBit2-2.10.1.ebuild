# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.10.1.ebuild,v 1.3 2004/06/16 09:32:08 lv Exp $

inherit gnome2

DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"

IUSE="doc ssl"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa amd64 ~ia64 ~mips"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/popt-1.5
	>=dev-libs/libIDL-0.7.4
	dev-util/indent
	ssl? ( >=dev-libs/openssl-0.9.6 )"
# FIXME linc is now integrated, but a block isn't necessary
# and probably complicated FIXME

# FIXME ssl is optional, but not switchable

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS"

src_unpack() {
	unpack ${A}

	# this patch fixes a bug in CORBA_free() where it doesnt take proper
	# structure alignment into account. the nautilus bug on amd64, alpha, and
	# various other non-x86 archs that caused it to segfault with more than
	# two fstab entries with the user option is now fixed.
	cd ${S} ; epatch ${FILESDIR}/orbit2-alignment-fix.patch
}
