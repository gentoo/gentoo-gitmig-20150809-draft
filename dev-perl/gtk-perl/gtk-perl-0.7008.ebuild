# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008.ebuild,v 1.4 2002/02/09 21:30:55 verwilst Exp $

S=${WORKDIR}/Gtk-Perl-${PV}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/Gtk-Perl-0.7008.tar.gz"
HOMEPAGE="http://www.perl.org/"
SLOT="0"
DEPEND=">=x11-libs/gtk+-1.2.10-r4 
	sys-devel/perl 
	dev-perl/XML-Writer 
	dev-perl/XML-Parser 
	gnome? ( gnome-base/gnome-core )"


src_compile() {                           
  local myconf
  if [ -z "`use gnome`" ] ; then
    myconf="--without-guessing"
  fi
  perl Makefile.PL $myconf
  make || die
}

src_install() {                               
  make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
  dodoc ChangeLog MANIFEST NOTES README VERSIONS WARNING
}





