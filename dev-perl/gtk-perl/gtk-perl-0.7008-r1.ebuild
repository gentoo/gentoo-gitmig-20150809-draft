# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008-r1.ebuild,v 1.2 2002/05/04 23:22:11 seemant Exp $

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"
SLOT="0"
DEPEND=">=x11-libs/gtk+-1.2.10-r4 
	sys-devel/perl 
	dev-perl/XML-Writer 
	dev-perl/XML-Parser 
	gnome? ( gnome-base/gnome-libs )"

src_compile() {

	local myconf

	use gnome ||  myconf="--without-guessing"

	perl Makefile.PL ${myconf}
	make || die
}

src_install() {															 
	make \
		PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		install || die
	
	eval `perl '-V:installarchlib'`
	sed -e "s:${D}::g" \
		${D}/${installarchlib}/perllocal.pod > ${D}/${installarchlib}/gtk.pod
	
	rm -f ${D}/${installarchlib}/perllocal.pod

	dodoc ChangeLog MANIFEST NOTES README VERSIONS WARNING
}

pkg_postinst() {
	
	eval `perl '-V:installarchlib'`
	cat ${installarchlib}/gtk.pod >> ${installarchlib}/perllocal.pod
}
