# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-perl/gtk2-perl-1.224.0.ebuild,v 1.1 2011/08/05 18:15:04 tove Exp $

EAPI=4

MY_PN=Gtk2
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.224
inherit perl-module
#inherit virtualx

DESCRIPTION="Perl bindings for GTK2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-perl/Cairo
	>=dev-perl/glib-perl-1.220
	>=dev-perl/Pango-1.220"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.300
	>=dev-perl/extutils-pkgconfig-1.030"

#RDEPEND+=" || ( <x11-libs/gtk+-2.22.1-r1[jpeg] x11-libs/gdk-pixbuf[jpeg] )"
#SRC_TEST=do
#src_test(){
#	Xmake test || die
#}
