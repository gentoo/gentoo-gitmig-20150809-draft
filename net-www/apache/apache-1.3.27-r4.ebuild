# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-1.3.27-r4.ebuild,v 1.13 2003/12/26 01:07:37 robbat2 Exp $

IUSE="ipv6 pam"

mod_ssl_ver=2.8.14

S=${WORKDIR}/${PN}_${PV}
DESCRIPTION="The Apache Web Server"
HOMEPAGE="http://www.apache.org http://www.modssl.org"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa arm"
SRC_URI="http://httpd.apache.org/dist/httpd/apache_${PV}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2
	ftp://ftp.modssl.org/source/mod_ssl-${mod_ssl_ver}-${PV}.tar.gz
	ipv6? http://motoyuki.bsdclub.org/data/IPv6/apache-${PV}-mod_ssl-${mod_ssl_ver}-v6-20021004.diff.gz"
# The mod_ssl archive is only for providing the EAPI patch in here.
# You should install the net-www/mod_ssl package for the actual DSO.

DEPEND="dev-lang/perl sys-libs/db
	>=dev-libs/mm-1.1.3
	>=sys-libs/gdbm-1.8
	>=dev-libs/expat-1.95.2"
LICENSE="Apache-1.1"
SLOT="1"

src_unpack() {
	local myssl
	unpack ${A} || die
	cd ${S} || die
	bzip2 -dc ${DISTDIR}/${P}-gentoo.diff.bz2 | patch -p1 || die

	#Make apachectl read /etc/conf.d/apache
	patch -p1 <${FILESDIR}/apache-1.3.27-apachectl.patch || die

	# yet another perl path fix..
	cp htdocs/manual/search/manual-index.cgi \
		htdocs/manual/search/manual-index.cgi.orig
	sed -e "s:/usr/local/bin/perl5:/usr/bin/perl:" \
		htdocs/manual/search/manual-index.cgi.orig \
		> htdocs/manual/search/manual-index.cgi
	rm -f htdocs/manual/search/manual-index.cgi.orig

	# setup eapi...
	myssl=${WORKDIR}/mod_ssl-${mod_ssl_ver}-${PV}
	cp ${myssl}/pkg.eapi/*.h src/include
	cp ${myssl}/pkg.eapi/*.c src/ap
	patch -p0 < ${myssl}/pkg.eapi/eapi.patch || die eapi

	# set a reasonable MM_CORE_PATH location..
	mv src/include/httpd.h src/include/httpd.h.orig
	sed -e 's:logs/mm:/var/cache/apache-mm/mm:' \
		src/include/httpd.h.orig > src/include/httpd.h

	# thanks drey@rt.mipt.ru for these two ...
	if use ipv6; then
		zcat ${DISTDIR}/apache-${PV}-mod_ssl-${mod_ssl_ver}-v6-20021004.diff.gz | patch -p0 || die
	fi

	if use pam; then
		patch -p1 <${FILESDIR}/suexec_pam_gentoo.patch || die
	fi

	# Detect db4 correctly
	patch -p1 <${FILESDIR}/apache-1.3.27_db4_gentoo.patch || die
}

src_compile() {
	local myconf mycflags
	mycflags="${CFLAGS}"
	unset CFLAGS ; unset CXXFLAGS
	use ipv6 && myconf="--enable-rule=INET6"

	# Allow users to move the default data directory by setting the
	# home directory of the 'apache' user elsewhere.
	DATA_DIR=`getent passwd apache | cut -d: -f6`
	if [ -z "$DATA_DIR" ]; then
		DATA_DIR="/home/httpd"
		eerror "DATA_DIR is null! Using default."
		eerror "Create the apache user and set the homedir to your desired location."
	fi
	einfo "Using $DATA_DIR as apache's default data directory."

	select_modules_config || \
	die "couldn't find apache-builtin-mods config file"

	#-DBUFFERED_LOGS
	OPTIM="${mycflags} -DHARD_SERVER_LIMIT=${HARD_SERVER_LIMIT:=512} \
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
		--suexec-docroot=/home \
		--suexec-safepath="/bin:/usr/bin" \
		--suexec-logfile=/var/log/apache/suexec_log \
		\
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	# Allow users to move the default data directory by setting the
	# home directory of the 'apache' user elsewhere.
	DATA_DIR=`getent passwd apache | cut -d: -f6`
	if [ -z "$DATA_DIR" ]; then
		eerror "DATA_DIR is null! Using defaults."
		eerror "You probably want to check /etc/passwd"
		DATA_DIR="/home/httpd"
	fi

	GID=`getent group apache | cut -d: -f3`
	if [ -z "${GID}" ]; then
		einfo "Using default GID of 81 for Apache"
		GID=81
	fi

	local myfile
	make install-quiet root=${D} || die
	dodoc ABOUT_APACHE Announcement INSTALL* LICENSE* README* WARNING* \
		${FILESDIR}/robots.txt

	fowners root.${GID} /usr/sbin/suexec
	fperms 4710 /usr/sbin/suexec
	#fowners apache.apache ${DATA_DIR}
	#fowners apache.apache ${DATA_DIR}/htdocs

	# nice support scripts..
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
	rm -f ${D}/etc/apache/conf/apache.conf.default
	rm -f ${D}/etc/apache/conf/access.conf*
	rm -f ${D}/etc/apache/conf/srm.conf*

	# We can't delete this if users specify /var/httpd for datadir
	#	rm -rf ${D}/var

	# now the config files..
	insinto /etc/apache/conf
	doins ${FILESDIR}/conf/commonapache.conf
	doins ${FILESDIR}/conf/apache.conf

	#this ebuild doesnt use /var/www/localhost but the config templates
	#in CVS now do, so just roll those changes back here; #29843
	perl -pi -e 's|var/www/localhost|home/httpd|;' \
		${D}/etc/apache/conf/apache.conf \
		${D}/etc/apache/conf/commonapache.conf

	# Added by Jason Wever <weeve@gentoo.org>
	# A little sedfu to fix bug #7172 for sparc64s
	if [ ${ARCH} = "sparc" ]
	then
		sed -i -e '15a\AcceptMutex fcntl' \
			${D}/etc/apache/conf/apache.conf
	fi

	insinto /etc/apache/conf/vhosts
	doins ${FILESDIR}/conf/VirtualHomePages.conf
	doins ${FILESDIR}/conf/DynamicVhosts.conf
	doins ${FILESDIR}/conf/Vhosts.conf

	exeinto /etc/init.d ; newexe ${FILESDIR}/apache.rc6 apache
	insinto /etc/conf.d ; newins ${FILESDIR}/apache.confd apache
	insinto /etc/apache ; doins ${FILESDIR}/apache-builtin-mods

	if use pam; then
		insinto /etc/pam.d ; newins ${FILESDIR}/suexec.pam suexec
	fi

	if [ "$DATA_DIR" != "/home/httpd" ]; then
		einfo "Updating data_dir path."
		echo grep -lr /home/httpd ${D}
		grep -lr /home/httpd ${D}
		sleep 30s
		for FILE in `grep -lr /home/httpd ${D}`; do
			echo "Running sed on: ${FILE}"
			cp ${FILE} ${FILE}.orig
			echo sed "s:/home/httpd:$DATA_DIR:g"
			sed "s:/home/httpd:$DATA_DIR:g" < ${FILE}.orig > ${FILE}
			rm ${FILE}.orig
		done
	fi

	keepdir /var/cache/apache /var/cache/apache-mm /usr/lib/apache-extramodules /etc/apache/conf/addon-modules /var/log/apache
}

pkg_postinst() {
	# these are in baselayout now; it will not hurt to leave them here though
	# moved to pkg_postinst by jnelson, moved to pkg_preinst by lostlogic
	getent group apache >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		groupadd -g 81 apache || die "problem adding group apache"
	fi

	# usermod returns 2 on user-exists-but-no-flags-given
	#usermod apache &>/dev/null
	#if [ $? != 2 ]; then
	getent passwd apache >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		useradd -u 81 -g apache -s /bin/false -d /home/httpd -c "apache" apache
		assert "problem adding user apache"
	fi
}

parse_modules_config() {
	local filename=$1
	local name=""
	local dso=""
	local disable=""
	[ -f ${filename} ] || return 1
	einfo "Using ${filename} for builtins."
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
