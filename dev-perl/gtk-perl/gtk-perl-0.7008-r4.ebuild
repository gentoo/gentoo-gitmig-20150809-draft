# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008-r4.ebuild,v 1.5 2002/07/26 04:43:20 gerk Exp $

inherit perl-module

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	media-libs/gdk-pixbuf"

newdepend "=x11-libs/gtk+-1.2* \
	dev-perl/XML-Writer \
	dev-perl/XML-Parser \
	gnome-base/gnome-libs"

mydoc="VERSIONS WARNING NOTES"
