# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n/kde-i18n-3.0.3.ebuild,v 1.1 2002/08/20 09:51:33 danarmak Exp $

inherit kde-i18n
S=${WORKDIR}/${P}

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	
	# we need to patch the Makefile.in's of <lang>/docs/common/ for each
	# languager, but we can't patch Makefile.am's, so better than patching in
	# src_compile, we make -f Makefile.cvs here in src_unpack.
	cd ${S}
	make -f Makefile.cvs
	for x in `cat subdirs`; do
		cd ${S}/${x}
		[ -d docs/common ] && \
			( patch -p0 < ${DISTDIR}/kde-i18n-gentoo.patch || die )
	done 

}
