# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/subversion/subversion-0.8.0.ebuild,v 1.3 2002/02/08 12:41:47 gbevin Exp $

S=${WORKDIR}/svn
S_APACHE=${WORKDIR}/httpd-2_0_31
S_APR=${WORKDIR}/apr
S_APRUTIL=${WORKDIR}/apr-util
S_AUTOCONF=${WORKDIR}/autoconf-2.52
S_BDB=${WORKDIR}/db-4.0.14/build_unix
S_SVNCLIENT=${WORKDIR}/svnclient
S_SVNSERVER=${WORKDIR}/svnserver
I_APACHE=${WORKDIR}/tmpinstall_httpd-2_0_31
I_AUTOCONF=${WORKDIR}/tmpinstall_autoconf-2.52
I_BDB=${WORKDIR}/tmpinstall_db-4.0.14
I_SVNCLIENT=${WORKDIR}/tmpinstall_svnclient
I_SVNSERVER=${WORKDIR}/tmpinstall_svnserver

DESCRIPTION="A compelling replacement for CVS"
SRC_URI="http://www.tigris.org/files/15/63/subversion-r909.tar.gz
	http://www.sleepycat.com/update/4.0.14/db-4.0.14.tar.gz
	http://cvs.apache.org/snapshots/apr/apr_20020208112804.tar.gz
	http://cvs.apache.org/snapshots/apr-util/apr-util_20020208112819.tar.gz
	http://www.apache.org/dist/httpd/httpd-2_0_31-alpha.tar.gz
	ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.52.tar.bz2"
HOMEPAGE="http://subversion.tigris.org/"

DEPEND="virtual/glibc
	>=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	>=sys-devel/libtool-1.4.1-r1
	>=sys-devel/bison-1.28-r3
	>=sys-devel/m4-1.4o-r2
	>=net-misc/neon-0.18.5"
RDEPEND="virtual/glibc
	>=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	>=sys-devel/m4-1.4o-r2
	>=net-misc/neon-0.18.5"

src_compile() {
	# default path settings for subversion components
	svnpaths="--prefix=/usr/svn \
	    --mandir=/usr/svn/share/man \
	    --infodir=/usr/svn/share/info \
	    --datadir=/usr/svn/share \
	    --sysconfdir=/etc \
	    --localstatedir=/var/lib \
		--host=${CHOST}"

	# configure berkeley db
	cd ${S_BDB}
	../dist/configure \
	    $svnpaths || die "../dist/configure of berkeley db failed"
	# build berkeley db
	emake || die "make of berkeley db failed"
	# install temporary version of berkeley db
	make prefix=${I_BDB} install || die "temporary installation of berkeley db failed"
	# make the system pick up the installed berkeley db libs before others
	export LD_LIBRARY_PATH="${I_BDB}/lib"
	
	# bootstrap subversion from version 0.8.0
	cd ${WORKDIR}/subversion-r909
	./configure \
		--with-berkeley-db=${I_BDB} \
		--enable-maintainer-mode \
		--disable-shared
	emake || die "make of subversion bootstrap failed"

	# get latest subversion version from cvs
	cd ${WORKDIR}
	subversion-r909/subversion/clients/cmdline/svn checkout http://svn.collab.net/repos/svn/trunk -d svn
	# remove old bootstrap version
	rm -rf ${WORKDIR}/subversion-r909
	
	# configure autoconf
	cd ${S_AUTOCONF}
	./configure \
		--prefix=${I_AUTOCONF} \
		--infodir=${I_AUTOCONF}/share/info \
		--mandir=${I_AUTOCONF}/share/man \
		--target=${CHOST} || die "./configure of autoconf failed"
	# build autoconf
	emake || die "make of autoconf failed"
	# install temporary version of autoconf
	make install || die "temporary installation of autoconf failed"
	# set the correct paths so that this new version of autoconf will be picked up instead
	# of the old version that gentoo uses by default
	export PATH="$I_AUTOCONF/bin:$PATH"

	cd ${S}
	# create a link to the apr and apr-utils sources
	ln -sf ${S_APR} apr
	ln -sf ${S_APRUTIL} apr-util
	# generate the configure scripts
	sh ./autogen.sh || die "autoconf of subversion failed"
	
	# make subversion client build directory
	mkdir -p ${S_SVNCLIENT}
	# configure subversion client
	cd ${S_SVNCLIENT}
	../svn/configure \
		$svnpaths \
		--with-berkeley-db=${I_BDB} \
		--with-neon=/usr \
		--enable-maintainer-mode \
		--disable-shared || die "./configure of subversion client failed"
	# build subversion client
	emake LD_LIBRARY_PATH="${I_BDB}/lib" || die "make of subversion client failed"
	# install temporary version of subversion client
	make LD_LIBRARY_PATH="${I_APACHE}/lib:${LD_LIBRARY_PATH}" \
		prefix=${I_SVNCLIENT} \
		mandir=${I_SVNCLIENT}/share/man \
		infodir=${I_SVNCLIENT}/share/info install || die "temporary installation of subversion client failed"
	
	return

	# configure apache
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
	# fix the apache sources to correctly work with LD_LIBRARY_PATH
	mv srclib/pcre/Makefile srclib/pcre/Makefile_orig
	sed -e "s#./dftables#LD_LIBRARY_PATH=\"${LD_LIBRARY_PATH}\" ./dftables#" \
		srclib/pcre/Makefile_orig > srclib/pcre/Makefile
	mv server/Makefile server/Makefile_orig
	sed -e "s#./gen_test_char#LD_LIBRARY_PATH=\"${LD_LIBRARY_PATH}\" ./gen_test_char#" \
		server/Makefile_orig > server/Makefile
	# build apache
	emake || die "make of apache failed"
	# install temporary version of apache
	make prefix=${I_APACHE} install || die "temporary installation of apache failed"
	# change the paths in apxs to point to the temporarly installed version of apache
	# this will make subversions dav module install there
	mv ${I_APACHE}/bin/apxs ${I_APACHE}/bin/apxs_orig
	sed -e "s#/usr/svn#${I_APACHE}#" \
		${I_APACHE}/bin/apxs_orig > ${I_APACHE}/bin/apxs
	chmod +x ${I_APACHE}/bin/apxs

	# configure subversion server
	mkdir ../svnserver_obj
	cd ../svnserver_obj
	../svn/configure \
		$svnpaths \
		--with-berkeley-db=${I_BDB} \
		--with-neon=/usr \
		--with-apxs=${I_APACHE}/bin/apxs \
		--enable-maintainer-mode || die "./configure of subversion server failed"
	# build subversion server
	emake LD_LIBRARY_PATH="${I_BDB}/lib" || die "make of subversion server failed"
	# install temporary version of subversion server
	make LD_LIBRARY_PATH="${I_APACHE}/lib:${LD_LIBRARY_PATH}" \
		prefix=${I_SVNSERVER} \
		mandir=${I_SVNSERVER}/share/man \
		infodir=${I_SVNSERVER}/share/info install || die "temporary installation of subversion server failed"
}

src_install () {
	mkdir -p ${D}/usr/svn
	mkdir -p ${D}/usr/svn/lib

	cp -av ${I_SVNCLIENT}/* ${D}/usr/svn || die "installation of subversion client failed"
	cp -av ${I_BDB}/lib/* ${D}/usr/svn/lib || die "installation of berkeley db failed"
	cp -av ${I_APACHE}/* ${D}/usr/svn || die "installation of apache failed"
	
	cd ${D}/usr/svn
	for x in bin/apxs \
		build/config_vars.mk \
		conf/highperformance-std.conf \
		conf/highperformance.conf \
		conf/httpd-std.conf \
		conf/httpd.conf \
		conf/ssl-std.conf \
		conf/ssl.conf \
		conf/httpd.conf.bak
	do
		mv ${x} ${x}_orig
		sed -e "s#/var/tmp/portage/subversion-0.8.0/work/tmpinstall_httpd-2_0_31#/usr/svn#g" \
			${x}_orig > ${x}
			rm ${x}_orig
	done
	for x in bin/apu-config \
		build/config_vars.mk \
		lib/libsvn_fs.la
	do
		mv ${x} ${x}_orig
		sed -e "s#/var/tmp/portage/subversion-0.8.0/work/tmpinstall_db-4.0.14#/usr/svn#g" \
			${x}_orig > ${x}
			rm ${x}_orig
	done

cat << ENDL >> ${D}/usr/svn/conf/httpd.conf
<Location /svn/repos>
	DAV svn
	SVNPath /var/lib/svn
</Location>
ENDL
}
