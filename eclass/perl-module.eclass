# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-module.eclass,v 1.1 2002/05/05 02:58:39 seemant Exp $
# The perl-module eclass is designed to allow easier installation of perl
# modules, and their incorporation into the Gentoo Linux system.
ECLASS=base
EXPORT_FUNCTIONS src_compile src_install pkg_postinst pkg_prerm

newdepend ">=sys-devel/perl-5"
POD_DIR=/usr/share/perl/gentoo-pods

base_src_compile() {
	perl Makefile.PL ${myconf}
	make || die
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
		install || die

	eval `perl '-V:installarchlib'`
	sed -e "s:${D}::g" \
		${D}/${installarchlib}/perllocal.pod \
			> ${D}/${POD_DIR}/${P}
	
	rm -f ${D}/${installarchlib}/perllocal.pod

	dodoc ChangeLog MANIFEST NOTES README VERSIONS WARNING ToDo
}


base_pkg_postinst() {
	
	base_doperlmod

}

base_pkg_postrm() {
	
	base_doperlpod
}

base_doperlpod() {
	
	eval `perl '-V:installarchlib'`
	cat ${POD_DIR}/mod-* >> ${installarchlib}/perllocal.pod

}
