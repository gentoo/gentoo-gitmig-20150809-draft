# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-module.eclass,v 1.6 2002/05/05 11:10:18 seemant Exp $
# The perl-module eclass is designed to allow easier installation of perl
# modules, and their incorporation into the Gentoo Linux system.

#first inherit the pkg_postinst() and pkg_postrm() functions
. /usr/portage/eclass/inherit.eclass || die
inherit perl-post

ECLASS=base
EXPORT_FUNCTIONS src_compile src_install

newdepend ">=sys-devel/perl-5"

base_src_compile() {

	perl Makefile.PL ${myconf}
	make || die "compilation failed"
	make test || die "make test failed"
}

base_src_install() {

	dodir ${POD_DIR}
	
	make \
		PREFIX=${D}/usr \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLMAN2DIR=${D}/usr/share/man/man2 \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN4DIR=${D}/usr/share/man/man4 \
		INSTALLMAN5DIR=${D}/usr/share/man/man5 \
		INSTALLMAN6DIR=${D}/usr/share/man/man6 \
		INSTALLMAN7DIR=${D}/usr/share/man/man7 \
		INSTALLMAN8DIR=${D}/usr/share/man/man8 \
		${myinst}
		install || die

	sed -e "s:${D}::g" \
		${D}/${ARCH_LIB}/perllocal.pod \
			> ${D}/${POD_DIR}/${PF}.pod
	
	rm -f ${D}/${ARCH_LIB}/perllocal.pod

	dodoc ChangeLog MANIFEST NOTES README VERSIONS WARNING ToDo
}
