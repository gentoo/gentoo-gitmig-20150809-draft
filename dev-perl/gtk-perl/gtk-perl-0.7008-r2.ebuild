# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008-r2.ebuild,v 1.1 2002/05/05 10:59:45 seemant Exp $

# Inherit the perl-module.eclass functions
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"
SLOT="0"
newdepend ">=x11-libs/gtk+-1.2.10-r4 \
	dev-perl/XML-Writer \
	dev-perl/XML-Parser \
	gnome? ( gnome-base/gnome-libs )"

use gnome ||  myconf="--without-guessing"
