# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/subversion/subversion-0.8.0.ebuild,v 1.1 2002/02/07 08:30:58 gbevin Exp $

S=${WORKDIR}/subversion-r909
S_BDB=${WORKDIR}/db-4.0.14/build_unix
S_APACHE=${WORKDIR}/httpd-2_0_31
I_BDB=${WORKDIR}/tmpinstall_db-4.0.14
I_APACHE=${WORKDIR}/tmpinstall_httpd-2_0_31

DESCRIPTION="A compelling replacement for CVS"
SRC_URI="http://www.tigris.org/files/15/63/subversion-r909.tar.gz
	http://www.sleepycat.com/update/4.0.14/db-4.0.14.tar.gz
	http://www.apache.org/dist/httpd/httpd-2_0_31-alpha.tar.gz"
HOMEPAGE="http://subversion.tigris.org/"

DEPEND="virtual/glibc
	>=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	>=sys-devel/libtool-1.4.1-r1
	>=sys-devel/bison-1.28-r3"
RDEPEND="virtual/glibc
	>=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf apr
}

src_compile() {
	svnpaths="--prefix=/usr/svn \
	    --mandir=/usr/svn/share/man \
	    --infodir=/usr/svn/share/info \
	    --datadir=/usr/svn/share \
	    --sysconfdir=/etc \
	    --localstatedir=/var/lib \
		--host=${CHOST}"

	cd ${S_BDB}
	../dist/configure \
	    $svnpaths
	emake || die "make of berkeley db failed"
	make prefix=${I_BDB} install || die "temporary installation of berkeley db failed"
	export LD_LIBRARY_PATH="${I_BDB}/lib:${LD_LIBRARY_PATH}"
	
	cd ${S_APACHE}
	./buildconf
	./configure \
		$svnpaths \
		--enable-so \
		--enable-dav \
		--with-dbm=db4 \
		--with-berkeley-db=${I_BDB} \
		--enable-maintainer-mode || die "./configure of apache failed"
	make depend
	mv srclib/pcre/Makefile srclib/pcre/Makefile_orig
	sed -e "s#./dftables#LD_LIBRARY_PATH=\"${LD_LIBRARY_PATH}\" ./dftables#" \
		srclib/pcre/Makefile_orig > srclib/pcre/Makefile
	mv server/Makefile server/Makefile_orig
	sed -e "s#./gen_test_char#LD_LIBRARY_PATH=\"${LD_LIBRARY_PATH}\" ./gen_test_char#" \
		server/Makefile_orig > server/Makefile
	emake || die "make of apache failed"
	make prefix=${I_APACHE} install || die "temporary installation of apache failed"
	mv ${I_APACHE}/bin/apxs ${I_APACHE}/bin/apxs_orig
	sed -e "s#/usr/svn#${I_APACHE}#" \
		${I_APACHE}/bin/apxs_orig > ${I_APACHE}/bin/apxs
	chmod +x ${I_APACHE}/bin/apxs
	export LD_LIBRARY_PATH="${I_APACHE}/lib:${LD_LIBRARY_PATH}"

	cd ${S}
	./configure \
		$svnpaths \
		--with-berkeley-db=${I_BDB} \
		--with-apr=${I_APACHE} \
	    --with-apr-util=${I_APACHE} \
		--with-apxs=${I_APACHE}/bin/apxs \
		--enable-maintainer-mode || die "./configure of subversion failed"
	emake || die "make of subversion failed"
}

src_install () {
	cd ${S_BDB}
	make prefix=${D}/usr/svn install || die "installation of berkeley db failed"

	cd ${S_APACHE}
	make prefix=${D}/usr/svn install || die "installation of apache failed"
	
	cd ${S}
	make LD_LIBRARY_PATH="${D}/usr/svn/lib:${LD_LIBRARY_PATH}" \
		prefix=${D}/usr/svn install \
		mandir={D}/usr/svn/share/man \
		infodir={D}/usr/svn/share/info || die "installation of subversion failed"
}
