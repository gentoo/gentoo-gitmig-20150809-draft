# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-1.3.24-r6.ebuild,v 1.3 2002/07/14 20:25:23 aliz Exp $

mod_ssl_ver=2.8.8-${PV}
HARD_SERVER_LIMIT=512

S=${WORKDIR}/apache_${PV}
DESCRIPTION="The Apache Web Server"
HOMEPAGE="http://www.apache.org http://www.modssl.org"
KEYWORDS="x86"
SRC_URI="http://httpd.apache.org/dist/httpd/apache_${PV}.tar.gz
	ftp://ftp.modssl.org/source/mod_ssl-${mod_ssl_ver}.tar.gz"
# The mod_ssl archive is only for providing the EAPI patch in here.
# You should install the net-www/mod_ssl package for the actual DSO.

RDEPEND="virtual/glibc
	=sys-libs/db-1*
	=sys-libs/db-3*
	>=dev-libs/mm-1.1.3
	>=sys-libs/gdbm-1.8
	>=dev-libs/expat-1.95.2"
DEPEND="${RDEPEND} sys-devel/perl"
LICENSE="Apache-1.1"
SLOT="1"

pkg_setup() {
	# these are in baselayout now; it will not hurt to leave them here though..

	if ! groupmod apache; then
		groupadd -g 81 apache || die "problem adding group apache"
	fi

	if ! id apache; then
		useradd -u 81 -g apache -s /bin/false -d /home/httpd -c "apache" apache
		assert "problem adding user apache"
	fi

	select_modules_config || \
	die "couldn't find apache-builtin-mods config file"
}

src_unpack() {
	local myssl
	unpack ${A} ; cd ${S}

	# For Chunking Exploit
	cd src
	bzcat ${FILESDIR}/${PV}/proxy_http1.1_chunking.patch.bz2 | patch -p0 || die "Patch: proxy httpd1.1 chunking"
	cd ..

	# some nice patches..
	patch -p1 < ${FILESDIR}/${PV}/mdk/apache_1.3.11-apxs.patch || die m1
	patch -p1 < ${FILESDIR}/${PV}/mdk/apache_1.3.22-srvroot.patch || die m2
	patch -p1 < ${FILESDIR}/${PV}/mdk/apache-1.3.14-mkstemp.patch || die m3
	patch -p0 < ${FILESDIR}/${PV}/mdk/apache-1.3.20.manpage.patch || die m4
	patch -p1 < ${FILESDIR}/${PV}/deb/apxs_wrong_prefix || die d1
	patch -p1 < ${FILESDIR}/${PV}/deb/custom_response_segfaults || die d2
	patch -p1 < ${FILESDIR}/${PV}/deb/mime_type_fix || die d3
	patch -p1 < ${FILESDIR}/${PV}/deb/regex_must_conform_to_posix_for_LFS_to_work || die d4
	patch -p1 < ${FILESDIR}/${PV}/deb/suexec_combined || die d5
	patch -p1 < ${FILESDIR}/${PV}/deb/suexec_of_death || die d6
	patch -p1 < ${FILESDIR}/${PV}/deb/usr_bin_perl_owns_you || die d7

	# yet another perl path fix..
	cp htdocs/manual/search/manual-index.cgi \
		htdocs/manual/search/manual-index.cgi.orig
	sed -e "s:/usr/local/bin/perl5:/usr/bin/perl:" \
		htdocs/manual/search/manual-index.cgi.orig \
		> htdocs/manual/search/manual-index.cgi
	rm -f htdocs/manual/search/manual-index.cgi.orig

	# setup eapi...
	#
	# ALSO: patch the eapi patch for the
	# proxy-httpd1.1-chunk patch         -- NJ 2002 Jun 18 (pre1)
	#
	myssl=${S}/../mod_ssl-${mod_ssl_ver}
	cp ${myssl}/pkg.eapi/*.h src/include
	cp ${myssl}/pkg.eapi/*.c src/ap
	patch -p0 < ${FILESDIR}/${PV}/eapi_proxy_httpd1.1_chunk_fix.patch || die "Patch: eapi patch-fix"
	patch -p0 < ${myssl}/pkg.eapi/eapi.patch || die eapi

	# set a reasonable MM_CORE_PATH location..
	mv src/include/httpd.h src/include/httpd.h.orig
	sed -e 's:logs/mm:/var/cache/apache-mm/mm:' \
		src/include/httpd.h.orig > src/include/httpd.h

	# fix this silly script so it finds a db lib..
	mv src/helpers/find-dbm-lib src/helpers/find-dbm-lib.orig
	cp ${FILESDIR}/find-dbm-lib src/helpers
}

src_compile() {
	local myconf mycflags
	mycflags="${CFLAGS}"
	unset CFLAGS ; unset CXXFLAGS

	# Allow users to move the default data directory by setting the
	# home directory of the 'apache' user elsewhere.
	DATA_DIR=`grep apache /etc/passwd | cut -d: -f6`
	einfo "Using $DATA_DIR as the default data directory."

	if [ "$DATA_DIR" != "/home/httpd" ]; then
		einfo "Updating data_dir path."
		for FILE in `grep -lr /home/httpd ${WORKDIR}`; do
			cp ${FILE} ${FILE}.orig
			sed "s:/home/httpd:$DATA_DIR:g" < ${FILE}.orig > ${FILE}
		done
	fi

	#-DBUFFERED_LOGS
	OPTIM="${mycflags} -DHARD_SERVER_LIMIT=${HARD_SERVER_LIMIT} \
		-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
	LIBS="-lgdbm -lpthread" \
	EAPI_MM=SYSTEM \
	./configure \
		--prefix=/usr \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sbindir=/usr/sbin \
		--libexecdir=/usr/lib/apache \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/apache/conf \
		--datadir=${DATA_DIR} \
		--iconsdir=${DATA_DIR}/icons \
		--htdocsdir=${DATA_DIR}/htdocs \
		--manualdir=/usr/share/doc/${PF}/manual \
		--cgidir=${DATA_DIR}/cgi-bin \
		--includedir=/usr/include/apache \
		--localstatedir=/var \
		--runtimedir=/var/run \
		--logfiledir=/var/log/apache \
		--proxycachedir=/var/cache/apache \
		--serverroot=/etc/apache \
		\
		--target=apache \
		--server-uid=apache \
		--server-gid=apache \
		--enable-rule=EAPI \
		--enable-rule=SHARED_CHAIN \
		--with-perl=/usr/bin/perl \
		\
		${MY_BUILTINS} \
		\
		--enable-suexec \
		--suexec-uidmin=1000 \
		--suexec-gidmin=100 \
		--suexec-caller=apache \
		--suexec-userdir=public_html \
		--suexec-docroot=${DATA_DIR}/htdocs \
		--suexec-safepath="/bin:/usr/bin" \
		--suexec-logfile=/var/log/apache/suexec_log \
		\
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {

	local myfile
#	make install-quiet root=${D} || die
	make install root=${D} || die
	dodoc ABOUT_APACHE Announcement INSTALL* LICENSE* README* WARNING*


	# Allow users to move the default data directory by setting the
	# home directory of the 'apache' user elsewhere.
	DATA_DIR=`grep apache /etc/passwd | cut -d: -f6`

	fowners root.apache /usr/sbin/suexec
	fperms 4710 /usr/sbin/suexec
	#fowners apache.apache ${DATA_DIR}
	#fowners apache.apache ${DATA_DIR}/htdocs

	# nice support scripts..    # apachefixconf
	for myfile in apacheaddmod apachedelmod \
		apachelogserverstatus apachesplitlogfile
	do
		exeinto /usr/sbin
		doexe ${FILESDIR}/$myfile
	done

	# setup links in /etc/apache..
	cd ${D}/etc/apache
	ln -sf ../../usr/lib/apache modules
	# apxs needs this to pickup the right lib for install..
	ln -sf ../../usr/lib lib
	ln -sf ../../var/log/apache logs
	ln -sf ../../usr/lib/apache-extramodules extramodules

	# drop in a convenient link to the manual
	dosym /usr/share/doc/${PF}/manual ${DATA_DIR}/htdocs/manual

	# deprecated config files, empty dirs..
	rm -f ${D}/etc/apache/conf/access.conf*
	rm -f ${D}/etc/apache/conf/srm.conf*

	# We can't delete this if users specify /var/httpd for datadir
	#	rm -rf ${D}/var

	# now the config files..
	insinto /etc/apache/conf
	doins ${FILESDIR}/conf/commonapache.conf
	doins ${FILESDIR}/conf/apache.conf
			
	insinto /etc/apache/conf/vhosts
	doins ${FILESDIR}/conf/VirtualHomePages.conf
	doins ${FILESDIR}/conf/DynamicVhosts.conf
	doins ${FILESDIR}/conf/Vhosts.conf

	exeinto /etc/init.d ; newexe ${FILESDIR}/apache.rc6 apache
	insinto /etc/conf.d ; newins ${FILESDIR}/apache.confd apache
	insinto /etc/apache ; doins ${FILESDIR}/apache-builtin-mods
}

pkg_postinst() {
	# empty dirs..
	install -d -o apache -g apache ${ROOT}/var/cache/apache
	install -d -o apache -g apache -m1333 ${ROOT}/var/cache/apache-mm
	install -d -o root -g root -m0755 ${ROOT}/usr/lib/apache-extramodules
	install -d -o root -g root -m0755 ${ROOT}/etc/apache/conf/addon-modules
	install -d -o root -g root -m0755 ${ROOT}/var/log/apache
}

parse_modules_config() {
	local filename=$1
	local name=""
	local dso=""
	local disable=""
	[ -f ${filename} ] || return 1
	einfo ">>> using ${filename} for builtins..."
	for i in `cat $filename | sed "s/^#.*//"` ; do
		if [ $i == "-" ] ; then
			disable="true"
		elif [ -z "$name" ] && [ ! -z "`echo $i | grep "mod_"`" ] ; then
			name=`echo $i | sed "s/mod_//"`
		elif [ "$disable" ] && ( [ $i == "static" ] || [ $i == "shared" ] ) ; then
			MY_BUILTINS="${MY_BUILTINS} --disable-module=$name"
			name="" ; disable=""
		elif [ $i == "static" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-module=$name --disable-shared=$name"
			name="" ; disable=""
		elif [ $i == "shared" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-module=$name --enable-shared=$name"
			name="" ; disable=""
		fi
	done
}

select_modules_config() {
	parse_modules_config /etc/apache/apache-builtin-mods || \
	parse_modules_config ${FILESDIR}/apache-builtin-mods || \
	return 1
}
