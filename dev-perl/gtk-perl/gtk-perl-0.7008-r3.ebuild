# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008-r3.ebuild,v 1.6 2002/07/25 04:13:27 seemant Exp $

# Inherit the perl-module.eclass functions

inherit perl-module

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.perl.org/"
SLOT="0"
newdepend "=x11-libs/gtk+-1.2* \
	dev-perl/XML-Writer \
	dev-perl/XML-Parser \
	gnome-base/gnome-libs"

mydoc="VERSIONS WARNING NOTES"
