# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/subversion/subversion-0.10_pre1.ebuild,v 1.12 2003/05/08 11:17:53 phosphan Exp $

S=${WORKDIR}/svn
S_APACHE=${WORKDIR}/httpd-2.0
S_APR=${WORKDIR}/apr
S_APRUTIL=${WORKDIR}/apr-util
S_AUTOCONF=${WORKDIR}/autoconf-2.52
S_BDB=${WORKDIR}/db-4.0.14/build_unix
I_APACHE=${WORKDIR}/tmpinstall_httpd
I_AUTOCONF=${WORKDIR}/tmpinstall_autoconf-2.52
I_BDB=${WORKDIR}/tmpinstall_db-4.0.14
I_SVN=${WORKDIR}/tmpinstall_svn

DESCRIPTION="A compelling replacement for CVS"
SRC_URI="http://www.sleepycat.com/update/4.0.14/db-4.0.14.tar.gz
	ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.52.tar.bz2
	http://www.gbevin.com/gentoo/apr-subversion-200202261456.tar.bz2
	http://www.gbevin.com/gentoo/apr-util-subversion-200202261456.tar.bz2
	http://www.gbevin.com/gentoo/httpd-subversion-200202261456.tar.bz2
	http://www.gbevin.com/gentoo/svn-200202261456.tar.bz2"
HOMEPAGE="http://subversion.tigris.org/"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="~x86 ~sparc "

DEPEND=">=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	>=sys-devel/libtool-1.4.1-r1
	>=sys-devel/bison-1.28-r3
	~sys-devel/m4-1.4
	=net-misc/neon-0.19.2*"
RDEPEND=">=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	~sys-devel/m4-1.4
	=net-misc/neon-0.19.2*"
	
src_bootstrap() {
	cd ${WORKDIR}

	# bootstrap subversion from version 0.9.0
	unpack ${DISTDIR}/subversion-r1302.tar.gz
	cd ${WORKDIR}/subversion-r1302
	econf \
		--with-berkeley-db=${I_BDB} \
		--enable-maintainer-mode \
		--disable-shared
	emake || die "make of subversion bootstrap failed"

	# get latest subversion version from cvs
	cd ${WORKDIR}
	subversion-r1302/subversion/clients/cmdline/svn checkout http://svn.collab.net/repos/svn/trunk -d svn
}

src_compile_bdb() {
	# configure berkeley db
	cd ${S_BDB}
	../dist/configure \
		--prefix=/usr/svn \
		--mandir=/usr/svn/share/man \
		--infodir=/usr/svn/share/info \
		--datadir=/usr/svn/share \
		--localstatedir=/var/lib \
		--host=${CHOST} || die "../dist/configure of berkeley db failed"

	# build berkeley db
	emake || die "make of berkeley db failed"
	# install temporary version of berkeley db
	make prefix=${I_BDB} install || die "temporary installation of berkeley db failed"
}

src_compile_apache() {
	# copy the apr and apr-util dirs
	rm -rf ${S_APACHE}/srclib/apr ${S_APACHE}/srclib/apr-util
	cp -a ${S_APR} ${S_APACHE}/srclib/apr
	cp -a ${S_APRUTIL} ${S_APACHE}/srclib/apr-util

	# configure apache
	cd ${S_APACHE}
	./buildconf
	./configure \
		--prefix=/usr/svn \
	    --mandir=/usr/svn/share/man \
	    --infodir=/usr/svn/share/info \
	    --datadir=/usr/svn/share \
	    --localstatedir=/var/lib \
		--host=${CHOST} \
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
}

src_compile_autoconf() {
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
}

src_compile_svn() {
	cd ${S}
	# create a copy of the most recent apr and apr-utils sources
	rm -rf apr apr-util
	cp -a ${S_APR} apr
	cp -a ${S_APRUTIL} apr-util
	# generate the configure scripts
	sh ./autogen.sh || die "autoconf of subversion failed"
	# configure subversion
	# have to install in temporary location first and can't sue DESTDIR
	# with make install since otherwise the libraries are wrongly installed
	./configure \
		--prefix=${I_SVN} \
		--with-berkeley-db=${I_BDB} \
		--with-neon=/usr \
		--with-apxs=${I_APACHE}/bin/apxs \
		--enable-maintainer-mode || die "./configure of subversion failed"
	# build subversion
	emake LD_LIBRARY_PATH="${I_BDB}/lib" || die "make of subversion failed"
	# install temporary version of subversion
	export LD_LIBRARY_PATH="${I_SVN}/lib:$LD_LIBRARY_PATH"
	make LD_LIBRARY_PATH="${I_BDB}/lib:${I_APACHE}/lib:${I_SVN}/lib" install || die "temporary installation of subversion failed"
}

src_compile() {
	src_compile_bdb
	# make the system pick up the installed berkeley db libs before others
	export LD_LIBRARY_PATH="${I_BDB}/lib"
	
	src_compile_apache
	# make the system have access to the cvs head libraries of apache 2.0
	export LD_LIBRARY_PATH="${I_APACHE}/lib:$LD_LIBRARY_PATH"
	
	src_compile_autoconf
	# set the correct paths so that this new version of autoconf will be picked up instead
	# of the old version that gentoo uses by default
	export PATH="$I_AUTOCONF/bin:$PATH"

	src_compile_svn
}

src_install () {
	# copy the prior temporary installs to the image dir
	dodir /usr/svn/lib
	cp -av ${I_BDB}/lib/* ${D}/usr/svn/lib || die "installation of berkeley db failed"
	cp -av ${I_APACHE}/* ${D}/usr/svn || die "installation of apache failed"
	cp -av ${I_SVN}/* ${D}/usr/svn || die "installation of subversion failed"
	
	# install documentation
	dodoc BUGS COMMITTERS COPYING HACKING IDEAS INSTALL PORTING README
	cd notes
	for f in *.txt
	do
		dodoc ${f}
	done
	
	# remove portage /var/tmp paths from files
	cd ${D}/usr/svn
	for x in bin/apxs \
		bin/apu-config \
		bin/apr-config \
		build/config_vars.mk \
		conf/highperformance-std.conf \
		conf/highperformance.conf \
		conf/httpd-std.conf \
		conf/httpd.conf \
		conf/ssl-std.conf \
		conf/ssl.conf \
		conf/httpd.conf.bak \
		lib/libsvn_delta.la \
		lib/libsvn_ra_dav.la \
		lib/libexpat.la \
		lib/libsvn_subr.la \
		lib/libaprutil.la \
		lib/libsvn_ra_local.la \
		lib/libsvn_repos.la \
		lib/libapr.la \
		lib/libsvn_client.la \
		lib/libsvn_fs.la \
		lib/libsvn_ra.la \
		lib/libsvn_wc.la
	do
		mv ${x} ${x}_orig
		sed -e "s#/var/tmp/portage/${P}/work/tmpinstall_svn#/usr/svn#g" \
			-e "s#/var/tmp/portage/${P}/work/tmpinstall_httpd#/usr/svn#g" \
			-e "s#/var/tmp/portage/${P}/work/tmpinstall_db-4.0.14#/usr/svn#g" \
			${x}_orig > ${x}
			rm ${x}_orig
	done

	# add the subversion path to the apache config
	cat << ENDL >> ${D}/usr/svn/conf/httpd.conf
<Location /svn/repos>
	DAV svn
	SVNPath /var/lib/svn
</Location>
ENDL

	# setup gentoo to make using subversion easier
	dodir /var/lib/svn/logs
	touch ${D}/usr/svn/logs/.keep
	insinto /usr/bin
	dosym /usr/svn/bin/svn /usr/bin/svn
	dosym /usr/svn/bin/svnadmin /usr/bin/svnadmin
	dosym /usr/svn/bin/svnlook /usr/bin/svnlook
	insinto /etc/env.d
	echo "LDPATH=/usr/svn/lib" > ${D}/etc/env.d/10subversion
}

pkg_config() {
	einfo ">>> Initializing the database ..."
	if [ -f /var/lib/svn/db ] ; then
        echo "A subversion repository already exists and I will not overwrite it."
		echo "Delete /var/lib/svn first if you're sure you want to have a clean version."
	else
		einfo ">>> Populating repository directory ..."
		# create initial repository
		LD_LIBRARY_PATH="/usr/svn/lib:$LD_LIBRARY_PATH" /usr/svn/bin/svnadmin create /var/lib/svn

		einfo ">>> Setting repository permissions ..."
		chown -Rf nobody.nobody /var/lib/svn
		chmod -Rf 755 /var/lib/svn
	fi
}
