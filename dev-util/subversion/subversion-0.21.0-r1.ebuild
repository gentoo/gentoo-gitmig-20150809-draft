# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/subversion/subversion-0.21.0-r1.ebuild,v 1.4 2003/05/12 20:52:38 mholzer Exp $

inherit libtool

DESCRIPTION="A compelling replacement for CVS"
SRC_URI="http://www.sleepycat.com/update/snapshot/db-4.0.14.tar.gz
	http://subversion.tigris.org/files/documents/15/3712/${P}.tar.gz"
HOMEPAGE="http://subversion.tigris.org/"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE="ssl apache2"

S_DB="${WORKDIR}/db-4.0.14/build_unix"

DEPEND=">=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	>=sys-devel/libtool-1.4.1-r1
	>=sys-devel/bison-1.28-r3
	apache2? ( >=net-www/apache-2.0.45 )
	!apache2? ( !>=apache-2* )
	!dev-libs/apr
	~sys-devel/m4-1.4
	>=dev-lang/swig-1.3.16
	>=net-misc/neon-0.23.8"

RDEPEND=">=dev-lang/python-2.0
	>=sys-apps/diffutils-2.7.7
	~sys-devel/m4-1.4"

pkg_setup() {
	if use apache2; then
		einfo "The apache2 subversion module will be built, and libapr from the"
		einfo "apache package will be used instead of the included"
	else
		einfo "Please note that subversion and apache2 cannot be installed"
		einfo "simultaneously without specifying the apache2 use flag. This is"
		einfo "because subversion installs its own libapr and libapr-util in that"
		einfo "case."
	fi
}
	
src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	has_version =db-4* || (
		unpack db-4.0.14.tar.gz
	)
	cd ${S}
}

src_compile() {
	elibtoolize

	has_version =db-4* || (
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
	) #no db4

	cd ${S}
	use ssl && myconf="${myconf} --with-ssl"
	use ssl || myconf="${myconf} --without-ssl"

	use apache2 && myconf="${myconf} --with-apxs=/usr/sbin/apxs2 \
		--with-apr=/usr --with-apr-util=/usr"
	use apache2 || myconf="${myconf} --without-apxs"
	has_version =db-4* || myconf="${myconf} --with-berkeley-db=${WORKDIR}/dbinst"

	LDFLAGS=${LDFLAGS} econf ${myconf} \
		--with-neon=/usr \
		--disable-mod-activation \
		--with-python=/usr/bin/python \
		--with-swig ||die "configuration failed"
	# build subversion
	emake || die "make of subversion failed"

	#building fails without the apache apr-util as includes are wrong.
	if use apache2; then
		emake swig-py || die "subversion python bindings failed"
	else
		emake SVN_APR_INCLUDES="-I${S}/apr/include -I${S}/apr-util/include" swig-py || die "subversion python bindings failed"
	fi
}


src_install () {
	mkdir -p ${D}/etc/apache2/conf
	mkdir -p ${D}/etc/share

	has_version =db-4* || (
		mkdir -p ${D}/usr/share/subversion/bin
		cp ${WORKDIR}/dbinst/bin/* ${D}/usr/share/subversion/bin/
	)

	make DESTDIR=${D} install || die "Installation of subversion failed"
	make install-swig-py DESTDIR=${D} DISTUTIL_PARAM=--prefix=${D} || die "Installation of subversion python bindings failed"
	mv ${D}/usr/lib/apache2 ${D}/usr/lib/apache2-extramodules

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
	cd ${S}
	echo "installing html book"
	dohtml -r doc/book/book/book.html doc/book/book/styles.css doc/book/book/images
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
	einfo "A repository needs to be created using the ebuild ${PN} config command"
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

