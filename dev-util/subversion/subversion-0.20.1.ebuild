# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/subversion/subversion-0.20.1.ebuild,v 1.4 2003/04/29 11:14:22 pauldv Exp $


DESCRIPTION="A compelling replacement for CVS"
SRC_URI="http://www.sleepycat.com/update/4.0.14/db-4.0.14.tar.gz
	http://subversion.tigris.org/files/documents/15/3440/${P}.tar.gz"
HOMEPAGE="http://subversion.tigris.org/"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE="ssl"

S_DB="${WORKDIR}/db-4.0.14/build_unix"

DEPEND=">=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	>=sys-devel/libtool-1.4.1-r1
	>=sys-devel/bison-1.28-r3
	>=net-www/apache-2.0.45
	~sys-devel/m4-1.4
	>=dev-lang/swig-1.3.16
	>=net-misc/neon-0.23.8"

RDEPEND=">=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	~sys-devel/m4-1.4"
	
src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	unpack db-4.0.14.tar.gz
	cd ${S}
#	cat packages/rpm/redhat-8.x/install.patch | \
#	sed -e "s,RPM_BUILD_ROOT,DESTDIR,g" -e "s,usr/lib/httpd/modules,usr/lib/apache2-extramodules,g" | patch -p1
}

src_compile() {
	cd ${S_DB}
	../dist/configure \
                --prefix=/usr \
                --mandir=/usr/share/man \
                --infodir=/usr/share/info \
                --datadir=/usr/share \
                --sysconfdir=/etc \
                --localstatedir=/var/lib \
                --disable-compat185 \
                --disable-cxx \
		--disable-tcl \
		--disable-java \
		--disable-shared \
		--with-uniquename
	make || die "db make failed"
	[ -e ${WORKDIR}/dbinst ] && rm -rf ${WORKDIR}/dbinst
	mkdir -p ${WORKDIR}/dbinst/lib
	make prefix=${WORKDIR}/dbinst install ||die
	mkdir ${WORKDIR}/dbinst/include/db4
	cp ${WORKDIR}/dbinst/include/*.h ${WORKDIR}/dbinst/include/db4
	mv ${WORKDIR}/dbinst/lib/libdb.a ${WORKDIR}/dbinst/lib/libdb4.a
	cat <<EOF >${WORKDIR}/dbinst/lib/libdb4.so
GROUP( ${WORKDIR}/dbinst/lib/libdb4.a /usr/lib/libdb.so)
EOF

	cd ${S}
	use ssl && myconf="${myconf} --with-ssl"
	use ssl || myconf="${myconf} --without-ssl"

	LDFLAGS="-L${S}/subversion/libsvn_client/.libs \
        -L${S}/subversion/libsvn_delta/.libs \
        -L${S}/subversion/libsvn_fs/.libs \
        -L${S}/subversion/libsvn_repos/.libs \
        -L${S}/subversion/libsvn_ra/.libs \
        -L${S}/subversion/libsvn_auth/.libs \
        -L${S}/subversion/libsvn_ra_dav/.libs \
        -L${S}/subversion/libsvn_ra_local/.libs \
        -L${S}/subversion/libsvn_ra_svn/.libs \
        -L${S}/subversion/libsvn_subr/.libs \
        -L${S}/subversion/libsvn_wc/.libs \
	-L${WORKDIR}/dbinst/lib"


	LDFLAGS=${LDFLAGS} econf ${myconf} --with-apxs=/usr/sbin/apxs2 \
		--with-apr=/usr \
		--with-apr-util=/usr \
		--with-berkeley-db=${WORKDIR}/dbinst \
		--with-neon=/usr \
		--disable-mod-activation \
		--with-python=/usr/bin/python \
		--with-swig ||die "configuration failed"
	# build subversion
	emake || die "make of subversion failed"
	emake swig-py || die "subversion python bindings failed"
}


src_install () {
	mkdir -p ${D}/etc/apache2/conf
	mkdir -p ${D}/etc/share

#	dolib ${WORKDIR}/dbinst/lib/libdb-*.so
	mkdir -p ${D}/usr/share/subversion/bin
	cp ${WORKDIR}/dbinst/bin/* ${D}/usr/share/subversion/bin/

	make DESTDIR=${D} install || die "Installation of subversion failed"
	make install-swig-py DESTDIR=${D} DISTUTIL_PARAM=--prefix=${D} || die "Installation of subversion python bindings failed"
	mv ${D}/usr/lib/apache2 ${D}/usr/lib/apache2-extramodules
	# remove unwanted parts from the image dir

	# install cvs2svn
	dobin tools/cvs2svn/cvs2svn.py
	mv ${D}/usr/bin/cvs2svn.py ${D}/usr/bin/cvs2svn
	doman tools/cvs2svn/cvs2svn.1

	# move python bindings
	mkdir -p ${D}/usr/lib/python2.2/site-packages
	cp -r tools/cvs2svn/rcsparse ${D}/usr/lib/python2.2/site-packages
	mv ${D}/usr/lib/svn-python/svn ${D}/usr/lib/python2.2/site-packages
	rmdir ${D}/usr/lib/svn-python

	dodoc BUGS COMMITTERS COPYING HACKING IDEAS INSTALL PORTING README
	dodoc tools/xslt/svnindex.css tools/xslt/svnindex.xsl

	# install documentation
	cd notes
	for f in *.txt
	do
		dodoc ${f}
	done
#	mkdir -p ${D}/home/svn/repos
#	mkdir -p ${D}/home/svn/conf
	mkdir -p ${D}/etc/apache2/conf/modules.d
	cat <<EOF >${D}/etc/apache2/conf/modules.d/47_mod_dav_svn.conf
<IfDefine SVN>
  <IfModule !mod_dav_svn.c>
    LoadModule dav_svn_module	extramodules/mod_dav_svn.so
  </IfModule>
  <Location /svn/repos>
    DAV svn
    SVNPath /home/svn/repos
    AuthType Basic
    AuthName "Subversion repository"
    AuthUserFile /home/svn/conf/svnusers
    Require valid-user
  </Location>
</IfDefine>
EOF

}

pkg_postinst() {
	einfo "Subversion has multiple server types. To enable the http based version"
	einfo "you must edit /etc/conf.d/apache2 to include both \"-D DAV\" and \"-D SVN\""
	einfo ""
	einfo "A repository needs to be created using the ebuild ${N} config command"
	einfo "To allow web access a htpasswd file needs to be created using the"
	einfo "following command:"
	einfo "   htpasswd2 -m -c /home/svn/conf/svnusers USERNAME"
}

pkg_config() {
	einfo ">>> Initializing the database ..."
	if [ -f /home/svn/repos ] ; then
        echo "A subversion repository already exists and I will not overwrite it."
		echo "Delete /home/svn/repos first if you're sure you want to have a clean version."
	else
		mkdir -p /home/svn
		einfo ">>> Populating repository directory ..."
		# create initial repository
		/usr/bin/svnadmin create /home/svn/repos

		einfo ">>> Setting repository permissions ..."
		chown -Rf apache.apache /home/svn/repos
		chmod -Rf 755 /home/svn/repos
	fi
}

